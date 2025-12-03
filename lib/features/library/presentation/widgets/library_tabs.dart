import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

enum ContentType {
  movie,
  music,
  video;

  String get displayName {
    switch (this) {
      case ContentType.movie:
        return 'Películas/series';
      case ContentType.music:
        return 'Música';
      case ContentType.video:
        return 'Videos';
    }
  }
}

class LibraryTabs extends StatelessWidget {
  final bool isPatient;
  final String currentTab;
  final Function(String) onTabChange;
  final ContentType selectedType;
  final List<ContentType> availableTabs;
  final Function(ContentType) onContentTypeSelected;

  const LibraryTabs({
    super.key,
    required this.isPatient,
    required this.currentTab,
    required this.onTabChange,
    required this.selectedType,
    required this.availableTabs,
    required this.onContentTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isPatient)
          _buildPatientTabs()
        else
          _buildGeneralTabs(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildPatientTabs() {
    final selectedTabIndex = currentTab == 'assignments'
        ? 0
        : availableTabs.indexOf(selectedType) + 1;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTab(
            'Asignados',
            currentTab == 'assignments',
            () => onTabChange('assignments'),
          ),
          ...availableTabs.map((type) {
            final isSelected = currentTab == 'content' && selectedType == type;
            return _buildTab(
              type.displayName,
              isSelected,
              () {
                onTabChange('content');
                onContentTypeSelected(type);
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGeneralTabs() {
    return Row(
      children: availableTabs.map((type) {
        final isSelected = selectedType == type;
        return Expanded(
          child: _buildTab(
            type.displayName,
            isSelected,
            () => onContentTypeSelected(type),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTab(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? green65 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 15,
            color: isSelected ? green65 : white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
