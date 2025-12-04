
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/check_in/mood_selection_step.dart';
import '../widgets/check_in/category_selection_step.dart';
import '../widgets/check_in/details_step.dart';
import '../widgets/check_in/symptoms_selection_step.dart';
import '../widgets/check_in/levels_step.dart';
import '../widgets/check_in/summary_step.dart';
import '../bloc/tracking_bloc.dart';
import '../bloc/tracking_event.dart';
import '../bloc/tracking_state.dart';

class CheckInFormScreen extends StatefulWidget {
  const CheckInFormScreen({Key? key}) : super(key: key);

  @override
  State<CheckInFormScreen> createState() => _CheckInFormScreenState();
}

class _CheckInFormScreenState extends State<CheckInFormScreen> {
  int _currentStep = 0;
  final int _totalSteps = 6;

  // Form data
  int _moodLevel = 5;
  String _selectedMoodEmoji = '😐';
  String _moodDescription = '';
  List<String> _selectedCategories = [];
  List<String> _selectedSymptoms = [];
  int _emotionalLevel = 5;
  int _energyLevel = 5;
  int _sleepHours = 7;
  String _notes = '';

  bool _isSubmitting = false;

  String _getMoodEmoji(int level) {
    if (level <= 2) return '😢';
    if (level <= 4) return '😕';
    if (level <= 6) return '😐';
    if (level <= 8) return '🙂';
    return '😄';
  }

  String _getMoodDescription(int level) {
    if (level <= 2) return 'Me siento terrible';
    if (level <= 4) return 'Me siento mal';
    if (level <= 6) return 'Me siento regular';
    if (level <= 8) return 'Me siento bien';
    return 'Me siento excelente';
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    _moodDescription = _getMoodDescription(_moodLevel);

    // 1. Create Check-In
    context.read<TrackingBloc>().add(
          CreateCheckInEvent(
            emotionalLevel: _emotionalLevel,
            energyLevel: _energyLevel,
            moodDescription: _moodDescription,
            sleepHours: _sleepHours,
            symptoms: _selectedSymptoms,
            notes: _notes.isEmpty ? null : _notes,
          ),
        );
  }

  void _onCheckInCreated() {
    // 2. Create Emotional Calendar Entry
    final today = DateTime.now();
    final dateString =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}T00:00:00.000Z';

    context.read<TrackingBloc>().add(
          CreateEmotionalCalendarEntryEvent(
            date: dateString,
            emotionalEmoji: _selectedMoodEmoji,
            moodLevel: _moodLevel,
            emotionalTags: _selectedCategories,
          ),
        );
  }

  void _onBothCompleted() {
    // Refresh data
    context.read<TrackingBloc>().add(RefreshDataEvent());

    // Navigate back
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TrackingBloc, TrackingState>(
      listener: (context, state) {
        if (state is CheckInFormSuccess) {
          // Check-in created, now create calendar entry
          _onCheckInCreated();
        } else if (state is EmotionalCalendarFormSuccess) {
          // Both completed
          _onBothCompleted();
        } else if (state is CheckInFormError) {
          setState(() {
            _isSubmitting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is EmotionalCalendarFormError) {
          setState(() {
            _isSubmitting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF6B8E7C),
        appBar: AppBar(
          backgroundColor: const Color(0xFF6B8E7C),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  '${_currentStep + 1}/$_totalSteps',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),

              // Steps content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildCurrentStep(),
                ),
              ),

              // Navigation buttons
              if (_currentStep > 0 && _currentStep < _totalSteps - 1)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: _previousStep,
                        child: const Text(
                          'Atrás',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return MoodSelectionStep(
          selectedMood: _moodLevel,
          onMoodSelected: (level) {
            setState(() {
              _moodLevel = level;
              _selectedMoodEmoji = _getMoodEmoji(level);
            });
          },
          onNext: _nextStep,
        );

      case 1:
        return CategorySelectionStep(
          title: '¿Qué hizo que hoy fuera así?',
          categories: const ['Trabajo', 'Pareja', 'Familia'],
          selectedCategories: _selectedCategories,
          onCategoriesSelected: (categories) {
            setState(() {
              _selectedCategories = categories;
            });
          },
          onNext: _nextStep,
        );

      case 2:
        return DetailsStep(
          question: '¿Te gustaría dar más detalles de lo que pasó?',
          notes: _notes,
          onNotesChanged: (notes) {
            setState(() {
              _notes = notes;
            });
          },
          onNext: _nextStep,
          onSkip: _nextStep,
        );

      case 3:
        return SymptomsSelectionStep(
          selectedSymptoms: _selectedSymptoms,
          onSymptomsSelected: (symptoms) {
            setState(() {
              _selectedSymptoms = symptoms;
            });
          },
          onNext: _nextStep,
        );

      case 4:
        return LevelsStep(
          emotionalLevel: _emotionalLevel,
          onEmotionalLevelChanged: (level) {
            setState(() {
              _emotionalLevel = level;
            });
          },
          energyLevel: _energyLevel,
          onEnergyLevelChanged: (level) {
            setState(() {
              _energyLevel = level;
            });
          },
          sleepHours: _sleepHours,
          onSleepHoursChanged: (hours) {
            setState(() {
              _sleepHours = hours;
            });
          },
          onNext: _nextStep,
        );

      case 5:
        return SummaryStep(
          onSubmit: _submitForm,
          isLoading: _isSubmitting,
        );

      default:
        return const SizedBox();
    }
  }
}
