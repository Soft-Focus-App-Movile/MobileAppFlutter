import 'package:flutter/material.dart';
import '../ui/colors.dart';
import '../ui/text_styles.dart';

class InvitationCard extends StatelessWidget {
  final String code;
  final VoidCallback onCopyClick;
  final VoidCallback onShareClick;

  const InvitationCard({
    super.key,
    required this.code,
    required this.onCopyClick,
    required this.onShareClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: greenEC,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 96,
              top: 16,
              bottom: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  code,
                  style: crimsonSemiBold.copyWith(
                    fontSize: 24,
                    color: black,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onCopyClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowCB9D,
                        foregroundColor: black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Copiar',
                        style: sourceSansRegular.copyWith(
                          fontSize: 11,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: onShareClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowCB9D,
                        foregroundColor: black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Compartir',
                        style: sourceSansRegular.copyWith(
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -10,
          top: -20,
          child: Image.asset(
            'assets/images/koala_focus.png',
            width: 180,
            height: 180,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: green49.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.code,
                  size: 80,
                  color: green37,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
