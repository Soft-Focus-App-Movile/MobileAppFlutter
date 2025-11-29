import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/colors.dart' as AppColors;
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../auth/domain/models/user_type.dart';
import '../blocs/preferences/notification_preferences_bloc.dart';
import '../blocs/preferences/notification_preferences_event.dart';
import '../blocs/preferences/notification_preferences_state.dart';
import '../widgets/time_range_picker_dialog.dart';

class NotificationPreferencesPage extends StatelessWidget {
  final UserType userType;

  const NotificationPreferencesPage({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationPreferencesBloc, NotificationPreferencesState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF222222)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Notificaciones',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 18,
                color: AppColors.green49,
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, NotificationPreferencesState state) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.green49),
      );
    }

    if (state.error != null) {
      return _buildErrorView(context, state.error!);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            _buildPreferencesCard(context, state),
            if (state.isSaving) ...[
              const SizedBox(height: 16),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: AppColors.green49,
                  strokeWidth: 2,
                ),
              ),
            ],
            if (state.successMessage != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFECF8EC),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  state.successMessage!,
                  style: AppTextStyles.sourceSansRegular.copyWith(
                    color: const Color(0xFF378037),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context, NotificationPreferencesState state) {
    final masterPreference = state.preferences.isNotEmpty ? state.preferences.first : null;

    if (masterPreference == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configuración',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.green49,
              ),
            ),
            const SizedBox(height: 16),
            _buildMasterSwitch(context, masterPreference),
            if (userType == UserType.PSYCHOLOGIST && masterPreference.isEnabled) ...[
              const Divider(color: Color(0xFFD9D9D9), thickness: 0.5, height: 32),
              _buildScheduleSection(context, masterPreference),
            ],
            if (userType != UserType.PSYCHOLOGIST && masterPreference.isEnabled) ...[
              const Divider(color: Color(0xFFD9D9D9), thickness: 0.5, height: 32),
              _buildInfoCard(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMasterSwitch(BuildContext context, dynamic preference) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recibir notificaciones',
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF222222),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                preference.isEnabled ? 'Activado' : 'Desactivado',
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 12,
                  color: const Color(0xFF808080),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: preference.isEnabled,
          onChanged: (_) => context.read<NotificationPreferencesBloc>().add(
                const ToggleMasterPreference(),
              ),
          activeColor: Colors.white,
          activeTrackColor: AppColors.green49,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: const Color(0xFFB2B2B2),
        ),
      ],
    );
  }

  Widget _buildScheduleSection(BuildContext context, dynamic preference) {
    final formatter = DateFormat('HH:mm');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Horario de recepción',
          style: AppTextStyles.sourceSansRegular.copyWith(
            fontSize: 14,
            color: const Color(0xFF222222),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Desde',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF808080),
                      ),
                    ),
                    Text(
                      formatter.format(
                        DateTime(0, 1, 1, preference.schedule?.startTime.hour ?? 7,
                            preference.schedule?.startTime.minute ?? 0),
                      ),
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Text('—', style: TextStyle(color: Color(0xFF808080))),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Hasta',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF808080),
                      ),
                    ),
                    Text(
                      formatter.format(
                        DateTime(0, 1, 1, preference.schedule?.endTime.hour ?? 0,
                            preference.schedule?.endTime.minute ?? 0),
                      ),
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 16,
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, color: AppColors.green49, size: 20),
                onPressed: () => _showTimePickerDialog(context, preference),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFECF8EC).withOpacity(0.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF378037), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dentro del horario:',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF378037),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Recibirás todas las notificaciones',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF378037),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fuera del horario:',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 12,
                        color: const Color(0xFF378037),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Solo alertas de crisis urgentes',
                      style: AppTextStyles.sourceSansRegular.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF378037),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECF8EC).withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF378037), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Recibirás todas las notificaciones del sistema',
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 12,
                color: const Color(0xFF378037),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              style: AppTextStyles.sourceSansRegular.copyWith(
                color: const Color(0xFFE53935),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<NotificationPreferencesBloc>().add(
                    const LoadPreferences(),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green49,
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTimePickerDialog(BuildContext context, dynamic preference) {
    showDialog(
      context: context,
      builder: (dialogContext) => TimeRangePickerDialog(
        startTime: preference.schedule?.startTime ?? const TimeOfDay(hour: 7, minute: 0),
        endTime: preference.schedule?.endTime ?? const TimeOfDay(hour: 0, minute: 0),
        onConfirm: (start, end) {
          context.read<NotificationPreferencesBloc>().add(
                UpdateSchedule(startTime: start, endTime: end),
              );
        },
      ),
    );
  }
}