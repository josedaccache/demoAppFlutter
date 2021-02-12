// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SourceItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceItem _$SourceItemFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id', 'name']);
  return SourceItem(
    id: json['id'] as String ?? '',
    name: json['name'] as String ?? '',
  );
}

Map<String, dynamic> _$SourceItemToJson(SourceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
