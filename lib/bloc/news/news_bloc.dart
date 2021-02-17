import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/apiresponses/NewsResponse.dart';
import 'package:dio/dio.dart';
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
    try {
      if (event is StartLoading) {
        print('sent HomeLoading');
        yield Loading();
      }
      if (event is NewsLoad) {
        NewsResponse apiResponse = await client.getNews();
        if (apiResponse != null) {
          yield Success(response: apiResponse);
        }
      }
    } catch (e) {
      yield Fail(error: "Error: " + e.toString());
    }
  }
}
