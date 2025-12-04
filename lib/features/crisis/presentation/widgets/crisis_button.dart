import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../blocs/crisis/crisis_bloc.dart';
import '../blocs/crisis/crisis_event.dart';
import '../blocs/crisis/crisis_state.dart';

class CrisisButton extends StatefulWidget {
  const CrisisButton({super.key});

  @override
  State<CrisisButton> createState() => _CrisisButtonState();
}

class _CrisisButtonState extends State<CrisisButton> {
  int _lastClickTime = 0;
  final int _clickCooldownMs = 3600000; // 1 hour in milliseconds

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrisisBloc, CrisisState>(
      listener: (context, state) {
        if (state is CrisisSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Alerta de crisis enviada exitosamente'),
              duration: Duration(seconds: 3),
            ),
          );
          context.read<CrisisBloc>().add(ResetCrisisState());
        } else if (state is CrisisErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              duration: const Duration(seconds: 3),
            ),
          );
          context.read<CrisisBloc>().add(ResetCrisisState());
        }
      },
      child: BlocBuilder<CrisisBloc, CrisisState>(
        builder: (context, state) {
          return Material(
            color: redE8,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () => _handleCrisisButtonTap(context, state),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'SOS',
                      style: crimsonSemiBold.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (state is CrisisLoadingState)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: white,
                          strokeWidth: 2,
                        ),
                      )
                    else
                      const Icon(
                        Icons.warning_rounded,
                        color: white,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleCrisisButtonTap(BuildContext context, CrisisState state) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final timeSinceLastClick = currentTime - _lastClickTime;

    if (state is CrisisLoadingState) {
      return;
    }

    if (timeSinceLastClick < _clickCooldownMs) {
      final remainingMinutes = ((_clickCooldownMs - timeSinceLastClick) / 60000).ceil();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ya enviaste una alerta. Espera $remainingMinutes minutos'),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    _showConfirmDialog(context);
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: redE8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          '¿Necesitas ayuda inmediata?',
          style: crimsonBold.copyWith(
            fontSize: 24,
            color: white,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            style: TextButton.styleFrom(
              side: BorderSide(color: grayD9, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Fue sin querer',
              style: sourceSansSemiBold.copyWith(color: grayD9),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _sendCrisisAlert(context);
            },
            style: TextButton.styleFrom(
              backgroundColor: grayD9,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Sí, necesito ayuda',
              style: sourceSansSemiBold.copyWith(color: redE8),
            ),
          ),
        ],
      ),
    );
  }

  void _sendCrisisAlert(BuildContext context) {
    _lastClickTime = DateTime.now().millisecondsSinceEpoch;
    // TODO: Get actual location from LocationHelper
    context.read<CrisisBloc>().add(
          SendCrisisAlert(
            latitude: null,
            longitude: null,
          ),
        );
  }
}
