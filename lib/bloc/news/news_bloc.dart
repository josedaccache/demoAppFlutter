import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/apiresponses/NewsResponse.dart';
import 'package:flutter_app/classes/NewsItem.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../network/APIClient.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial());

  final APIClient client =
      APIClient(Dio(BaseOptions(contentType: "application/json")));

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    final currentState = state;
    try {
      if (event is NewsLoad) {
        if (currentState is NewsInitial) {
          final NewsResponse apiResponse = await client.getNews();
          if (apiResponse != null) {
            yield Success(
              newsList: apiResponse.itemData,
              hasReachedMax: false,
              current: 1,
              max: 3
            );
            return;
          }
        }
        if (currentState is Success &&
            currentState.current != currentState.max) {
          final NewsResponse apiResponse = await client.getNews();
          if (apiResponse != null) {
            yield Success(
                newsList: new List.from(currentState.newsList)
                  ..addAll(apiResponse.itemData),
                hasReachedMax: currentState.current == currentState.max-1,
                current: currentState.current +1,
                max: 3
            );
            return;
          }
        }
      }
    } catch (e) {
      yield Fail(error: "Error: " + e.toString());
    }
  }

  @override
  Stream<Transition<NewsEvent, NewsState>> transformEvents(
    Stream<NewsEvent> events,
    TransitionFunction<NewsEvent, NewsState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 500)),
      transitionFn,
    );
  }

}
