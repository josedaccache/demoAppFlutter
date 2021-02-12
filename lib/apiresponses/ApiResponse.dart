import 'package:json_annotation/json_annotation.dart';

part 'ApiResponse.g.dart';

@JsonSerializable(nullable: false)
class ApiResponse {

  @JsonKey(name: 'status',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String status;

  @JsonKey(name: 'code',required: true, nullable: true, defaultValue: 0, includeIfNull: true)
  int code;

  @JsonKey(name: 'message',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String message;

  ApiResponse({this.status, this.code, this.message});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
