import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../blocs/psychologist_profile/psychologist_profile_state.dart';
import '../../../../psychologist/data/remote/psychologist_service.dart';
import '../../../../psychologist/domain/models/psychologist_stats.dart';

class PsychologistStatsPage extends StatefulWidget {
  final VoidCallback onNavigateBack;
  final PsychologistService psychologistService;

  const PsychologistStatsPage({
    super.key,
    required this.onNavigateBack,
    required this.psychologistService,
  });

  @override
  State<PsychologistStatsPage> createState() => _PsychologistStatsPageState();
}

class _PsychologistStatsPageState extends State<PsychologistStatsPage> {
  String? _fromDate;
  String? _toDate;
  bool _isRefreshing = false;
  PsychologistStats? _stats;
  bool _isLoadingStats = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _selectFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: green37,
              onPrimary: white,
              onSurface: black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fromDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: green37,
              onPrimary: white,
              onSurface: black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _toDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _clearFilter() {
    setState(() {
      _fromDate = null;
      _toDate = null;
    });
  }

  Future<void> _loadStats() async {
    setState(() {
      _isLoadingStats = true;
      _errorMessage = null;
    });

    try {
      final statsDto = await widget.psychologistService.getStats(
        fromDate: _fromDate,
        toDate: _toDate,
      );

      if (mounted) {
        setState(() {
          _stats = statsDto.toDomain();
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoadingStats = false;
        });
      }
    }
  }

  void _applyFilter() {
    _loadStats();
  }

  String _getEmotionalEmoji(double level) {
    if (level <= 2.0) return '😡';
    if (level <= 4.0) return '😢';
    if (level <= 6.0) return '😐';
    if (level <= 8.0) return '😊';
    return '😁';
  }

  String _formatStatsDate(String timestamp) {
    try {
      final dateTime = DateTime.parse(timestamp);
      return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    } catch (e) {
      return DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Mis Estadísticas',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: green37,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green37),
          onPressed: widget.onNavigateBack,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: green65),
            onPressed: _isLoadingStats ? null : _loadStats,
          ),
        ],
        backgroundColor: white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // Filtro de Fechas
            _buildDateFilterCard(),

            const SizedBox(height: 24),

            // Estadísticas
            if (_isLoadingStats)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(color: green65),
                ),
              )
            else if (_errorMessage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Error al cargar estadísticas',
                        style: crimsonSemiBold.copyWith(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _errorMessage!,
                        style: sourceSansRegular.copyWith(
                          fontSize: 14,
                          color: gray828,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _loadStats,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: green65,
                          foregroundColor: white,
                        ),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: [
                  // Card: Pacientes Activos
                  _buildStatsCard(
                    icon: Icons.people,
                    title: 'Pacientes Activos',
                    value: _stats?.activePatientsCount.toString() ?? '0',
                    subtitle: _stats != null && _stats!.activePatientsCount > 0
                        ? 'Pacientes en tratamiento activo'
                        : 'No tienes pacientes activos',
                  ),

                  const SizedBox(height: 16),

                  // Card: Alertas Pendientes
                  _buildStatsCard(
                    icon: Icons.warning_amber_rounded,
                    title: 'Alertas de Crisis Pendientes',
                    value: _stats?.pendingCrisisAlerts.toString() ?? '0',
                    subtitle: _stats != null && _stats!.pendingCrisisAlerts > 0
                        ? '${_stats!.pendingCrisisAlerts} alertas pendientes'
                        : 'No hay alertas pendientes',
                    isAlert: _stats != null && _stats!.pendingCrisisAlerts > 0,
                  ),

                  const SizedBox(height: 16),

                  // Card: Check-ins Completados Hoy
                  _buildStatsCard(
                    icon: Icons.calendar_today,
                    title: 'Check-ins Completados Hoy',
                    value: _stats?.todayCheckInsCompleted.toString() ?? '0',
                    subtitle: _stats != null && _stats!.todayCheckInsCompleted > 0
                        ? '${_stats!.todayCheckInsCompleted} pacientes completaron su check-in'
                        : 'Ningún paciente ha completado su check-in hoy',
                  ),

                  const SizedBox(height: 16),

                  // Card: Adherencia Promedio
                  _buildStatsCard(
                    icon: Icons.trending_up,
                    title: 'Tasa de Adherencia (Últimos 30 días)',
                    value: _stats != null ? '${_stats!.averageAdherenceRate.toStringAsFixed(1)}%' : '0%',
                    subtitle: _stats != null && _stats!.averageAdherenceRate > 0
                        ? 'Promedio de adherencia de tus pacientes'
                        : 'Sin datos de adherencia',
                  ),

                  const SizedBox(height: 16),

                  // Card: Pacientes Nuevos Este Mes
                  _buildStatsCard(
                    icon: Icons.person_add,
                    title: 'Pacientes Nuevos Este Mes',
                    value: _stats?.newPatientsThisMonth.toString() ?? '0',
                    subtitle: _stats != null && _stats!.newPatientsThisMonth > 0
                        ? '${_stats!.newPatientsThisMonth} pacientes nuevos'
                        : 'No has recibido pacientes nuevos este mes',
                  ),

                  const SizedBox(height: 16),

                  // Card: Estado Emocional Promedio
                  _buildEmotionalCard(
                    emoji: _getEmotionalEmoji(_stats?.averageEmotionalLevel ?? 0),
                    title: 'Estado Emocional Promedio',
                    value: _stats != null && _stats!.averageEmotionalLevel > 0
                        ? _stats!.averageEmotionalLevel.toStringAsFixed(1)
                        : '0.0',
                    maxValue: '10.0',
                    subtitle: _stats != null && _stats!.averageEmotionalLevel > 0
                        ? 'Promedio de tus pacientes'
                        : 'Sin datos de estado emocional',
                  ),

                  const SizedBox(height: 16),

                  // Fecha de actualización
                  Text(
                    _stats != null
                        ? 'Última actualización: ${_formatStatsDate(_stats!.statsGeneratedAt)}'
                        : 'Última actualización: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now())}',
                    style: sourceSansRegular.copyWith(
                      fontSize: 12,
                      color: grayA2,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilterCard() {
    return Card(
      color: white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.date_range, color: green65, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Filtro de Fechas',
                      style: crimsonSemiBold.copyWith(
                        fontSize: 16,
                        color: black,
                      ),
                    ),
                  ],
                ),
                if (_fromDate != null || _toDate != null)
                  TextButton(
                    onPressed: _clearFilter,
                    child: Text(
                      'Limpiar',
                      style: sourceSansRegular.copyWith(
                        fontSize: 14,
                        color: green65,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _fromDate != null && _toDate != null
                  ? 'Estadísticas desde $_fromDate hasta $_toDate'
                  : 'Selecciona un rango de fechas para filtrar',
              style: sourceSansRegular.copyWith(
                fontSize: 12,
                color: grayA2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDateButton(
                    label: 'Desde',
                    date: _fromDate,
                    onTap: _selectFromDate,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDateButton(
                    label: 'Hasta',
                    date: _toDate,
                    onTap: _selectToDate,
                  ),
                ),
              ],
            ),
            if (_fromDate != null && _toDate != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _applyFilter,
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: Text(
                    'Aplicar Filtro',
                    style: crimsonSemiBold.copyWith(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green65,
                    foregroundColor: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateButton({
    required String label,
    required String? date,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: date != null ? green65.withValues(alpha: 0.1) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: green65.withValues(alpha: 0.3)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, color: green65, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: sourceSansRegular.copyWith(
                  fontSize: 12,
                  color: green65,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            date ?? 'No seleccionada',
            style: (date != null ? crimsonSemiBold : sourceSansRegular).copyWith(
              fontSize: 13,
              color: date != null ? black : grayA2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    bool isAlert = false,
  }) {
    return Card(
      color: isAlert ? const Color(0xFFFFF3E0) : white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: isAlert ? const Color(0xFFFF6B00) : green65,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: crimsonSemiBold.copyWith(
                      fontSize: 18,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: crimsonSemiBold.copyWith(
                fontSize: 48,
                color: isAlert ? const Color(0xFFFF6B00) : green65,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: grayA2,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmotionalCard({
    required String emoji,
    required String title,
    required String value,
    required String maxValue,
    required String subtitle,
  }) {
    return Card(
      color: white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: crimsonSemiBold.copyWith(
                      fontSize: 18,
                      color: black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: crimsonSemiBold.copyWith(
                    fontSize: 48,
                    color: green65,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 4),
                  child: Text(
                    '/ $maxValue',
                    style: sourceSansRegular.copyWith(
                      fontSize: 20,
                      color: grayA2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: grayA2,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
