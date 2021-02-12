import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_app/apiresponses/ApiResponse.dart';
import 'package:flutter_app/classes/ImageItem.dart';

part 'ImageResponse.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class ImageResponse extends ApiResponse {

  @JsonKey(name: 'imageData',required: true, nullable: true, defaultValue: [], includeIfNull: true)
  List<ImageItem> imageData;

  ImageResponse({this.imageData});

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);

  @override
  String toString() {
    return this.message + this.status;
  }
}