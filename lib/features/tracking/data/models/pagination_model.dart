import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_model.freezed.dart';
part 'pagination_model.g.dart';

@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    required int currentPage,
    required int pageSize,
    required int totalCount,
    required int totalPages,
    required bool hasNextPage,
    required bool hasPreviousPage,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}
