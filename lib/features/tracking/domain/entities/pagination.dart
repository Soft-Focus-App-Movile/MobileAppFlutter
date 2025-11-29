import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int currentPage;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  const Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  @override
  List<Object?> get props => [
        currentPage,
        pageSize,
        totalCount,
        totalPages,
        hasNextPage,
        hasPreviousPage,
      ];
}