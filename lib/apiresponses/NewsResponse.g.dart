// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['status', 'code', 'message', 'data']);
  return NewsResponse(
    itemData: (json['data'] as List)
            ?.map((e) =>
                e == null ? null : NewsItem.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  )
    ..status = json['status'] as String ?? ''
    ..code = json['code'] as int ?? 0
    ..message = json['message'] as String ?? '';
}

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.itemData?.map((e) => e?.toJson())?.toList(),
    };
