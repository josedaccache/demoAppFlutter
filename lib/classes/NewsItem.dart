import 'package:json_annotation/json_annotation.dart';

import 'SourceItem.dart';

part 'NewsItem.g.dart';

@JsonSerializable(nullable: false,  explicitToJson: true)
class NewsItem{
  @JsonKey(name: 'source',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  SourceItem source;
  @JsonKey(name: 'author',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String author;
  @JsonKey(name: 'title',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String  title;
  @JsonKey(name: 'description',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String description;
  @JsonKey(name: 'url',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String url;
  @JsonKey(name: 'urlToImage',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String urlToImage;
  @JsonKey(name: 'publishedAt',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String publishedAt;
  @JsonKey(name: 'content',required: true, nullable: true, defaultValue: '', includeIfNull: true)
  String content;

  NewsItem(
      {this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  factory NewsItem.fromJson(Map<String, dynamic> json) =>
      _$NewsItemFromJson(json);

  Map<String, dynamic> toJson() => _$NewsItemToJson(this);
}