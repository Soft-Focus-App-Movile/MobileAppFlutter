// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListResponseDto _$NotificationListResponseDtoFromJson(
  Map<String, dynamic> json,
) => NotificationListResponseDto(
  notifications:
      (json['notifications'] as List<dynamic>?)
          ?.map(
            (e) => NotificationResponseDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 20,
);

Map<String, dynamic> _$NotificationListResponseDtoToJson(
  NotificationListResponseDto instance,
) => <String, dynamic>{
  'notifications': instance.notifications,
  'total': instance.total,
  'page': instance.page,
  'pageSize': instance.pageSize,
};
