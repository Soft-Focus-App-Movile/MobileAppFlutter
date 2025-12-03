import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

class SearchBarWithFilter extends StatelessWidget {
  final String searchQuery;
  final Function(String) onSearchQueryChange;
  final VoidCallback onFilterClick;

  const SearchBarWithFilter({
    super.key,
    required this.searchQuery,
    required this.onSearchQueryChange,
    required this.onFilterClick,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: gray2C,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: onSearchQueryChange,
                style: sourceSansRegular.copyWith(color: white),
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: sourceSansRegular.copyWith(color: gray808),
                  prefixIcon: const Icon(Icons.search, color: gray808),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: gray2C,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: onFilterClick,
              icon: const Icon(Icons.filter_list, color: white),
            ),
          ),
        ],
      ),
    );
  }
}
