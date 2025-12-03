import 'package:flutter/material.dart';

class CategorySelectionStep extends StatelessWidget {
  final String title;
  final List<String> categories;
  final List<String> selectedCategories;
  final Function(List<String>) onCategoriesSelected;
  final VoidCallback onNext;

  const CategorySelectionStep({
    Key? key,
    required this.title,
    required this.categories,
    required this.selectedCategories,
    required this.onCategoriesSelected,
    required this.onNext,
  }) : super(key: key);

  void _toggleCategory(String category) {
    final newSelection = List<String>.from(selectedCategories);
    if (newSelection.contains(category)) {
      newSelection.remove(category);
    } else {
      newSelection.add(category);
    }
    onCategoriesSelected(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        
        // Categories
        ...categories.map((category) {
          final isSelected = selectedCategories.contains(category);
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _toggleCategory(category),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.white 
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: TextStyle(
                          color: isSelected 
                              ? const Color(0xFF6B8E7C) 
                              : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle,
                          color: Color(0xFF6B8E7C),
                          size: 28,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        
        const SizedBox(height: 32),
        
        // Next button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: selectedCategories.isEmpty ? null : onNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF6B8E7C),
              disabledBackgroundColor: Colors.white.withOpacity(0.3),
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Siguiente',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
