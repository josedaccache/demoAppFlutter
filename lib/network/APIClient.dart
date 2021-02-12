import 'package:flutter_app/apiresponses/NewsResponse.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../utils/Utils.dart';
import '../apiresponses/ImageResponse.dart';
import '../apiresponses/ApiResponse.dart';
part 'APIClient.g.dart';

@RestApi(baseUrl: Utils.BASE_URL)
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  @GET(Utils.IMAGES_URL)
  Future<ImageResponse> getImages();

  @GET(Utils.SUCCESS_URL)
  Future<ApiResponse> getSuccess();

  @GET(Utils.SUCCESS_URL)
  Future<ApiResponse> getFailure();

  @GET(Utils.NEWS_URL)
  Future<NewsResponse> getNews();
}
