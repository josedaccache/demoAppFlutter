// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ImageResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponse _$ImageResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: const ['status', 'code', 'message', 'imageData']);
  return ImageResponse(
    imageData: (json['imageData'] as List)
            ?.map((e) => e == null
                ? null
                : ImageItem.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  )
    ..status = json['status'] as String ?? ''
    ..code = json['code'] as int ?? 0
    ..message = json['message'] as String ?? '';
}

Map<String, dynamic> _$ImageResponseToJson(ImageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'imageData': instance.imageData?.map((e) => e?.toJson())?.toList(),
    };
