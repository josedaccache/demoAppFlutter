// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ApiResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['status', 'code', 'message']);
  return ApiResponse(
    status: json['status'] as String ?? '',
    code: json['code'] as int ?? 0,
    message: json['message'] as String ?? '',
  );
}

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
