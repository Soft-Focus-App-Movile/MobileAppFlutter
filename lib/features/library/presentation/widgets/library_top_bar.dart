import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

class LibraryTopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPsychologist;
  final bool isSelectionMode;
  final VoidCallback onCancelSelection;

  const LibraryTopBar({
    super.key,
    required this.isPsychologist,
    required this.isSelectionMode,
    required this.onCancelSelection,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Biblioteca',
        style: crimsonSemiBold.copyWith(fontSize: 32, color: green49),
      ),
      actions: [
        if (isPsychologist && isSelectionMode)
          TextButton(
            onPressed: onCancelSelection,
            child: Text(
              'Cancelar',
              style: sourceSansRegular.copyWith(color: green49),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
