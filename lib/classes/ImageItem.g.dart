// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageItem _$ImageItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['source']);
  return ImageItem(
    source: json['source'] as String ?? '',
  );
}

Map<String, dynamic> _$ImageItemToJson(ImageItem instance) => <String, dynamic>{
      'source': instance.source,
    };
