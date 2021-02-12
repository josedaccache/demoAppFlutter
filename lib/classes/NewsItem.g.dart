// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsItem _$NewsItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const [
    'source',
    'author',
    'title',
    'description',
    'url',
    'urlToImage',
    'publishedAt',
    'content'
  ]);
  return NewsItem(
    source: json['source'] == null
        ? null
        : SourceItem.fromJson(json['source'] as Map<String, dynamic>) ?? '',
    author: json['author'] as String ?? '',
    title: json['title'] as String ?? '',
    description: json['description'] as String ?? '',
    url: json['url'] as String ?? '',
    urlToImage: json['urlToImage'] as String ?? '',
    publishedAt: json['publishedAt'] as String ?? '',
    content: json['content'] as String ?? '',
  );
}

Map<String, dynamic> _$NewsItemToJson(NewsItem instance) => <String, dynamic>{
      'source': instance.source?.toJson(),
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
