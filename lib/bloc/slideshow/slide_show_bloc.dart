import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/apiresponses/ImageResponse.dart';
import 'package:meta/meta.dart';

import '../../network/APIClient.dart';

part 'slide_show_event.dart';
part 'slide_show_state.dart';

class SlideShowBloc extends Bloc<SlideShowEvent, SlideShowState> {
  SlideShowBloc() : super(SlideShowInitial());


  final APIClient client = APIClient(
      Dio(BaseOptions(contentType: "application/json")));

  @override
  Stream<SlideShowState> mapEventToState(SlideShowEvent event,) async* {
    try {
      if (event is StartLoading) {
        print('sent HomeLoading');
        yield Loading();
      }
      if (event is ImageLoad) {
        ImageResponse apiResponse = await client.getImages();
        if (apiResponse != null) {
          yield Success(response: apiResponse);
        }
      }
    } catch (e) {
      yield Fail(error: "Error: " + e.toString());
    }
  }

}
