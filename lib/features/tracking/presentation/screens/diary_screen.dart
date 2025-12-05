import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_state.dart';
import '../bloc/tracking_event.dart';
import '../widgets/calendar/calendar_date_picker.dart' as custom;
import '../widgets/calendar/emotional_calendar_grid.dart';
import '../../../../core/navigation/route.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Load initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadEmotionalCalendar();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadEmotionalCalendar() {
    final firstDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
    final lastDayOfMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0);

    final startDate =
        '${firstDayOfMonth.year}-${firstDayOfMonth.month.toString().padLeft(2, '0')}-${firstDayOfMonth.day.toString().padLeft(2, '0')}';
    final endDate =
        '${lastDayOfMonth.year}-${lastDayOfMonth.month.toString().padLeft(2, '0')}-${lastDayOfMonth.day.toString().padLeft(2, '0')}';

    context.read<TrackingBloc>().add(
          LoadEmotionalCalendarEvent(
            startDate: startDate,
            endDate: endDate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Diario',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFF6B8E7C),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF6B8E7C),
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          tabs: const [
            Tab(text: 'Calendario'),
            Tab(text: 'Progreso'),
          ],
          onTap: (index) {
            if (index == 1) {
              context.push(AppRoute.progress.path);
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  _tabController.animateTo(0);
                }
              });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoute.checkInForm.path);
        },
        backgroundColor: const Color(0xFF6B8E7C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocBuilder<TrackingBloc, TrackingState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildCalendarTab(state),
              const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCalendarTab(TrackingState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          custom.CalendarDatePicker(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
              _loadEmotionalCalendar();
            },
          ),
          const SizedBox(height: 16),
          _buildCalendarGrid(state),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(TrackingState state) {
    List<dynamic> entries = [];
    
    if (state is TrackingLoaded && state.emotionalCalendar != null) {
      try {
        entries = state.emotionalCalendar!.entries;
      } catch (e) {
        // Si hay error, usar lista vacía
        entries = [];
      }
    }
    
    return _buildCalendarWithData(entries);
  }

  Widget _buildCalendarWithData(List<dynamic> entries) {
    final daysInMonth = DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
    final weekdayOfFirstDay = firstDayOfMonth.weekday;
    final leadingEmptyDays = weekdayOfFirstDay == 7 ? 0 : weekdayOfFirstDay;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['L', 'M', 'X', 'J', 'V', 'S', 'D']
                .map((day) => SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          day,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B8E7C),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 0.9,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: leadingEmptyDays + daysInMonth,
            itemBuilder: (context, index) {
              if (index < leadingEmptyDays) {
                return const SizedBox();
              }
              final day = index - leadingEmptyDays + 1;
              final date = DateTime(_selectedDate.year, _selectedDate.month, day);
              
              // Buscar entrada para este día
              dynamic entry;
              String emoji = '';
              bool hasEntry = false;
              
              try {
                for (var e in entries) {
                  if (e != null && e.date != null) {
                    final entryDate = e.date is DateTime ? e.date : DateTime.parse(e.date.toString());
                    if (entryDate.year == date.year && 
                        entryDate.month == date.month && 
                        entryDate.day == date.day) {
                      entry = e;
                      emoji = e.emotionalEmoji?.toString() ?? '';
                      hasEntry = emoji.isNotEmpty;
                      break;
                    }
                  }
                }
              } catch (e) {
                // Si hay error, mostrar día sin emoji
                hasEntry = false;
              }
              
              return GestureDetector(
                onTap: hasEntry ? () => _showEntryDetails(entry) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: hasEntry ? const Color(0xFFE8F5E9) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: hasEntry ? const Color(0xFF6B8E7C).withOpacity(0.3) : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasEntry) ...[
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          day.toString(),
                          style: const TextStyle(
                            fontSize: 8,
                            color: Color(0xFF6B8E7C),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else
                        Text(
                          day.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showEntryDetails(dynamic entry) {
    // Same implementation as before
  }

  String _formatDate(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} de ${months[date.month - 1]}, ${date.year}';
  }
}