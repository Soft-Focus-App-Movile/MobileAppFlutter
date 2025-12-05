import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

enum VideoCategory {
  meditation('Meditación', 'meditación', 'assets/icons/ic_meditation.svg'),
  breathing('Respiración', 'respiración', 'assets/icons/ic_breathing.svg'),
  relaxation('Relajación', 'relajación', 'assets/icons/ic_relaxation.svg');

  final String displayName;
  final String queryText;
  final String iconPath;

  const VideoCategory(this.displayName, this.queryText, this.iconPath);
}

class VideoCategorySelector extends StatelessWidget {
  final VideoCategory? selectedCategory;
  final Function(VideoCategory) onCategorySelected;

  const VideoCategorySelector({
    super.key,
    this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: VideoCategory.values.map((category) {
          final isSelected = selectedCategory == category;
          return _buildCategoryButton(category, isSelected);
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryButton(VideoCategory category, bool isSelected) {
    return GestureDetector(
      onTap: () => onCategorySelected(category),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? yellowCB9D : gray828,
            ),
            child: Center(
              child: SvgPicture.asset(
                category.iconPath,
                width: 28,
                height: 28,
                colorFilter: ColorFilter.mode(
                  isSelected ? black : white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            category.displayName,
            style: sourceSansRegular.copyWith(
              fontSize: 13,
              color: isSelected ? yellowCB9D : white,
            ),
          ),
        ],
      ),
    );
  }
}
