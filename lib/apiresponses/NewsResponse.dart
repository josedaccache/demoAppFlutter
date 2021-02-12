import 'package:flutter_app/classes/NewsItem.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:flutter_app/apiresponses/ApiResponse.dart';

part 'NewsResponse.g.dart';

@JsonSerializable(nullable: false, explicitToJson: true)
class NewsResponse extends ApiResponse {
  @JsonKey(
      name: 'data',
      required: true,
      nullable: true,
      defaultValue: [],
      includeIfNull: true)
  List<NewsItem> itemData;

  NewsResponse({this.itemData});

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
