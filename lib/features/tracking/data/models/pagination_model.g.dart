// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaginationModelImpl _$$PaginationModelImplFromJson(
  Map<String, dynamic> json,
) => _$PaginationModelImpl(
  currentPage: (json['currentPage'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalCount: (json['totalCount'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPreviousPage: json['hasPreviousPage'] as bool,
);

Map<String, dynamic> _$$PaginationModelImplToJson(
  _$PaginationModelImpl instance,
) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
