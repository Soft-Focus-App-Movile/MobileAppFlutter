import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/colors.dart' as AppColors;
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;

class TimeRangePickerDialog extends StatefulWidget {
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Function(TimeOfDay start, TimeOfDay end) onConfirm;

  const TimeRangePickerDialog({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onConfirm,
  });

  @override
  State<TimeRangePickerDialog> createState() => _TimeRangePickerDialogState();
}

class _TimeRangePickerDialogState extends State<TimeRangePickerDialog> {
  bool _isSelectingStart = true;
  late TimeOfDay _tempStartTime;
  late TimeOfDay _tempEndTime;

  @override
  void initState() {
    super.initState();
    _tempStartTime = widget.startTime;
    _tempEndTime = widget.endTime;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        _isSelectingStart ? 'Hora de inicio' : 'Hora de fin',
        style: AppTextStyles.sourceSansRegular.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF222222),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isSelectingStart
                ? 'Desde qué hora deseas recibir notificaciones'
                : 'Hasta qué hora deseas recibir todas las notificaciones',
            style: AppTextStyles.sourceSansRegular.copyWith(
              fontSize: 14,
              color: const Color(0xFF808080),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            width: 300,
            child: TimePickerDialog(
              initialTime: _isSelectingStart ? _tempStartTime : _tempEndTime,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancelar',
            style: AppTextStyles.sourceSansRegular.copyWith(
              color: const Color(0xFF808080),
            ),
          ),
        ),
        TextButton(
          onPressed: _handleConfirm,
          child: Text(
            _isSelectingStart ? 'Siguiente' : 'Guardar',
            style: AppTextStyles.sourceSansRegular.copyWith(
              color: AppColors.green49,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleConfirm() async {
    if (_isSelectingStart) {
      final time = await showTimePicker(
        context: context,
        initialTime: _tempStartTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.green49,
                onSurface: Color(0xFF222222),
              ),
            ),
            child: child!,
          );
        },
      );
      if (time != null) {
        setState(() {
          _tempStartTime = time;
          _isSelectingStart = false;
        });
      }
    } else {
      final time = await showTimePicker(
        context: context,
        initialTime: _tempEndTime,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.green49,
                onSurface: Color(0xFF222222),
              ),
            ),
            child: child!,
          );
        },
      );
      if (time != null) {
        _tempEndTime = time;
        widget.onConfirm(_tempStartTime, _tempEndTime);
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    }
  }
}