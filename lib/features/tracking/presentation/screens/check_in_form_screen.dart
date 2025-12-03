import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/check_in/mood_selection_step.dart';
import '../widgets/check_in/category_selection_step.dart';
import '../widgets/check_in/details_step.dart';
import '../widgets/check_in/symptoms_selection_step.dart';
import '../widgets/check_in/levels_step.dart';
import '../widgets/check_in/summary_step.dart';
import '../di/tracking_di.dart';
import '../providers/tracking_provider.dart';

class CheckInFormScreen extends ConsumerStatefulWidget {
  const CheckInFormScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CheckInFormScreen> createState() => _CheckInFormScreenState();
}

class _CheckInFormScreenState extends ConsumerState<CheckInFormScreen> {
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

  @override
  void initState() {
    super.initState();
    // Reset form states
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(checkInFormNotifierProvider.notifier).reset();
      ref.read(emotionalCalendarFormNotifierProvider.notifier).reset();
    });
  }

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
    _moodDescription = _getMoodDescription(_moodLevel);

    // 1. Create Check-In
    await ref.read(checkInFormNotifierProvider.notifier).createCheckIn(
          emotionalLevel: _emotionalLevel,
          energyLevel: _energyLevel,
          moodDescription: _moodDescription,
          sleepHours: _sleepHours,
          symptoms: _selectedSymptoms,
          notes: _notes.isEmpty ? null : _notes,
        );

    // 2. Create Emotional Calendar Entry
    final today = DateTime.now();
    final dateString = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}T00:00:00.000Z';

    await ref.read(emotionalCalendarFormNotifierProvider.notifier).createEmotionalCalendarEntry(
          date: dateString,
          emotionalEmoji: _selectedMoodEmoji,
          moodLevel: _moodLevel,
          emotionalTags: _selectedCategories,
        );
  }

  @override
  Widget build(BuildContext context) {
    final checkInFormState = ref.watch(checkInFormNotifierProvider);
    final emotionalCalendarFormState = ref.watch(emotionalCalendarFormNotifierProvider);

    // Listen to success state
    ref.listen<CheckInFormState>(checkInFormNotifierProvider, (previous, next) {
      if (next.isSuccess && emotionalCalendarFormState.isSuccess) {
        // Both completed successfully
        ref.read(trackingNotifierProvider.notifier).refreshData();
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pop();
            // Optionally navigate to diary
            // Navigator.of(context).pushReplacementNamed('/diary');
          }
        });
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    ref.listen<EmotionalCalendarFormState>(
      emotionalCalendarFormNotifierProvider,
      (previous, next) {
        if (next.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );

    return Scaffold(
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
                child: _buildCurrentStep(checkInFormState, emotionalCalendarFormState),
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
    );
  }

  Widget _buildCurrentStep(CheckInFormState checkInFormState, EmotionalCalendarFormState emotionalCalendarFormState) {
    final isLoading = checkInFormState.isLoading || emotionalCalendarFormState.isLoading;
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
          isLoading: isLoading,
        );

      default:
        return const SizedBox();
    }
  }
}