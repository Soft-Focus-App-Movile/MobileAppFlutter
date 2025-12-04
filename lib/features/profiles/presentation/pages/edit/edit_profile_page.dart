import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../blocs/profile/profile_event.dart';
import '../../blocs/profile/profile_state.dart';
import 'package:intl/intl.dart';

class EditProfilePage extends StatefulWidget {
  final VoidCallback onNavigateBack;

  const EditProfilePage({
    super.key,
    required this.onNavigateBack,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialBio = '';
  String _initialDateOfBirth = '';
  String _initialCountry = '';
  String _initialCity = '';
  String _initialGender = '';
  String _initialPhone = '';
  Set<String> _initialInterests = {};
  Set<String> _initialGoals = {};

  String _selectedDateOfBirth = '';
  String _selectedGender = '';
  Set<String> _selectedInterests = {};
  Set<String> _selectedGoals = {};
  File? _profileImage;

  final List<String> _interestOptions = [
    'Películas', 'Música', 'Deportes', 'Lectura', 'Viajes',
    'Cocina', 'Arte', 'Fotografía', 'Gaming', 'Naturaleza',
    'Tecnología', 'Mascotas'
  ];

  final List<String> _goalOptions = [
    'Reducir ansiedad', 'Manejar estrés', 'Mejorar sueño',
    'Aumentar autoestima', 'Controlar emociones', 'Superar depresión',
    'Mejorar relaciones', 'Aumentar confianza', 'Encontrar paz mental',
    'Desarrollo personal'
  ];

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<ProfileBloc>().state;
    if (state.user != null) {
      _initializeFields(state.user!);
    }
  }

  void _initializeFields(dynamic user) {
    if (_isInitialized) return;

    _initialFirstName = user.firstName ?? '';
    _initialLastName = user.lastName ?? '';
    _initialBio = user.bio ?? '';
    _initialDateOfBirth = user.dateOfBirth ?? '';
    _initialCountry = user.country ?? '';
    _initialCity = user.city ?? '';
    _initialGender = _mapGenderToBackend(user.gender ?? '');
    _initialPhone = user.phone ?? '';
    _initialInterests = Set.from(user.interests ?? []);
    _initialGoals = Set.from(user.mentalHealthGoals ?? []);

    _firstNameController.text = _initialFirstName;
    _lastNameController.text = _initialLastName;
    _bioController.text = _initialBio;
    _selectedDateOfBirth = _initialDateOfBirth;
    _countryController.text = _initialCountry;
    _cityController.text = _initialCity;
    _selectedGender = _initialGender;
    _phoneController.text = _initialPhone;
    _selectedInterests = Set.from(_initialInterests);
    _selectedGoals = Set.from(_initialGoals);
    _isInitialized = true;

    setState(() {});
  }

  String _mapGenderToBackend(String gender) {
    switch (gender) {
      case 'Femenino':
        return 'Female';
      case 'Masculino':
        return 'Male';
      case 'Otro':
        return 'Other';
      case 'Prefiero no decir':
        return 'PreferNotToSay';
      default:
        return gender;
    }
  }

  String _mapGenderToDisplay(String gender) {
    switch (gender) {
      case 'Female':
        return 'Femenino';
      case 'Male':
        return 'Masculino';
      case 'Other':
        return 'Otro';
      case 'PreferNotToSay':
        return 'Prefiero no decir';
      default:
        return gender.isEmpty ? 'Seleccionar' : gender;
    }
  }

  bool get _hasChanges {
    return _firstNameController.text != _initialFirstName ||
        _lastNameController.text != _initialLastName ||
        _bioController.text != _initialBio ||
        _selectedDateOfBirth != _initialDateOfBirth ||
        _countryController.text != _initialCountry ||
        _cityController.text != _initialCity ||
        _selectedGender != _initialGender ||
        _phoneController.text != _initialPhone ||
        !_selectedInterests.difference(_initialInterests).isEmpty ||
        !_initialInterests.difference(_selectedInterests).isEmpty ||
        !_selectedGoals.difference(_initialGoals).isEmpty ||
        !_initialGoals.difference(_selectedGoals).isEmpty ||
        _profileImage != null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Editar Perfil',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: green37,
          ),
        ),
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: green37),
          onPressed: widget.onNavigateBack,
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccess && state.user != null && !_isInitialized) {
            _initializeFields(state.user!);
          } else if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Perfil actualizado correctamente ✓'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
          child: Column(
            children: [
              _buildProfileImage(),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _EditableTextField(
                      label: 'Nombre',
                      controller: _firstNameController,
                      isEdited: _firstNameController.text != _initialFirstName,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _EditableTextField(
                      label: 'Apellido',
                      controller: _lastNameController,
                      isEdited: _lastNameController.text != _initialLastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _EditableTextField(
                label: 'Descripción',
                controller: _bioController,
                isEdited: _bioController.text != _initialBio,
                minLines: 3,
              ),
              const SizedBox(height: 16),
              _DateOfBirthPicker(
                selectedDate: _selectedDateOfBirth,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDateOfBirth = date;
                  });
                },
                isEdited: _selectedDateOfBirth != _initialDateOfBirth,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _EditableTextField(
                      label: 'País',
                      controller: _countryController,
                      isEdited: _countryController.text != _initialCountry,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _EditableTextField(
                      label: 'Ciudad',
                      controller: _cityController,
                      isEdited: _cityController.text != _initialCity,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _GenderDropdown(
                selectedGender: _selectedGender,
                onGenderSelected: (gender) {
                  setState(() {
                    _selectedGender = gender;
                  });
                },
                isEdited: _selectedGender != _initialGender,
              ),
              const SizedBox(height: 16),
              _EditableTextField(
                label: 'Número',
                controller: _phoneController,
                isEdited: _phoneController.text != _initialPhone,
              ),
              const SizedBox(height: 24),
              _ChipSelectionField(
                label: 'Intereses',
                options: _interestOptions,
                selectedOptions: _selectedInterests,
                onSelectionChange: (newSelection) {
                  setState(() {
                    _selectedInterests = newSelection;
                  });
                },
              ),
              const SizedBox(height: 16),
              _ChipSelectionField(
                label: 'Objetivos',
                options: _goalOptions,
                selectedOptions: _selectedGoals,
                onSelectionChange: (newSelection) {
                  setState(() {
                    _selectedGoals = newSelection;
                  });
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: widget.onNavigateBack,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: gray828,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _hasChanges ? _saveProfile : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green29,
                        disabledBackgroundColor: grayB2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    final state = context.watch<ProfileBloc>().state;
    final user = state.user;

    return Stack(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greenA3,
          ),
          child: _profileImage != null
              ? ClipOval(
                  child: Image.file(
                    _profileImage!,
                    fit: BoxFit.cover,
                  ),
                )
              : user?.profileImageUrl != null
                  ? ClipOval(
                      child: Image.network(
                        user!.profileImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: greenA3);
                        },
                      ),
                    )
                  : Container(),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: green29,
              ),
              child: const Icon(
                Icons.camera_alt,
                color: white,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de cambiar imagen en desarrollo'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _saveProfile() {
    context.read<ProfileBloc>().add(
          UpdateProfile(
            firstName: _firstNameController.text.isNotEmpty ? _firstNameController.text : null,
            lastName: _lastNameController.text.isNotEmpty ? _lastNameController.text : null,
            bio: _bioController.text.isNotEmpty ? _bioController.text : null,
            dateOfBirth: _selectedDateOfBirth.isNotEmpty ? _selectedDateOfBirth : null,
            country: _countryController.text.isNotEmpty ? _countryController.text : null,
            city: _cityController.text.isNotEmpty ? _cityController.text : null,
            gender: _selectedGender.isNotEmpty ? _selectedGender : null,
            phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
            interests: _selectedInterests.isNotEmpty ? _selectedInterests.toList() : null,
            mentalHealthGoals: _selectedGoals.isNotEmpty ? _selectedGoals.toList() : null,
            profileImageFile: _profileImage,
          ),
        );
  }
}

class _EditableTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEdited;
  final int minLines;

  const _EditableTextField({
    required this.label,
    required this.controller,
    required this.isEdited,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isEdited ? green37 : grayB2;
    final borderColor = isEdited ? green37 : grayB2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 14,
            color: gray828,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? null : 1,
          style: sourceSansRegular.copyWith(
            fontSize: 16,
            color: textColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEBEFE5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: green29),
            ),
          ),
        ),
      ],
    );
  }
}

class _GenderDropdown extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderSelected;
  final bool isEdited;

  const _GenderDropdown({
    required this.selectedGender,
    required this.onGenderSelected,
    required this.isEdited,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isEdited ? green37 : grayB2;
    final borderColor = isEdited ? green37 : grayB2;

    final genderOptions = {
      'Femenino': 'Female',
      'Masculino': 'Male',
      'Otro': 'Other',
      'Prefiero no decir': 'PreferNotToSay',
    };

    String displayValue = 'Seleccionar';
    if (selectedGender == 'Female') displayValue = 'Femenino';
    if (selectedGender == 'Male') displayValue = 'Masculino';
    if (selectedGender == 'Other') displayValue = 'Otro';
    if (selectedGender == 'PreferNotToSay') displayValue = 'Prefiero no decir';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Género',
          style: sourceSansRegular.copyWith(
            fontSize: 14,
            color: gray828,
          ),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          value: selectedGender.isEmpty ? null : selectedGender,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFEBEFE5),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: green29),
            ),
          ),
          hint: Text(
            displayValue,
            style: sourceSansRegular.copyWith(
              fontSize: 16,
              color: textColor,
            ),
          ),
          items: genderOptions.entries.map((entry) {
            return DropdownMenuItem(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              onGenderSelected(value);
            }
          },
        ),
      ],
    );
  }
}

class _DateOfBirthPicker extends StatelessWidget {
  final String selectedDate;
  final Function(String) onDateSelected;
  final bool isEdited;

  const _DateOfBirthPicker({
    required this.selectedDate,
    required this.onDateSelected,
    required this.isEdited,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isEdited ? green37 : grayB2;
    final borderColor = isEdited ? green37 : grayB2;

    String displayDate = 'Seleccionar fecha';
    if (selectedDate.isNotEmpty) {
      try {
        final date = DateTime.parse(selectedDate);
        displayDate = DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        displayDate = 'Seleccionar fecha';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha de Cumpleaños',
          style: sourceSansRegular.copyWith(
            fontSize: 14,
            color: gray828,
          ),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate.isNotEmpty
                  ? DateTime.parse(selectedDate)
                  : DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (picked != null) {
              final isoDate = picked.toIso8601String();
              onDateSelected(isoDate);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEBEFE5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  displayDate,
                  style: sourceSansRegular.copyWith(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: isEdited ? green37 : grayB2,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ChipSelectionField extends StatelessWidget {
  final String label;
  final List<String> options;
  final Set<String> selectedOptions;
  final Function(Set<String>) onSelectionChange;

  const _ChipSelectionField({
    required this.label,
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 14,
            color: gray828,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              selected: isSelected,
              label: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? white : gray828,
                ),
              ),
              backgroundColor: const Color(0xFFEBEFE5),
              selectedColor: green29,
              onSelected: (selected) {
                final newSelection = Set<String>.from(selectedOptions);
                if (selected) {
                  newSelection.add(option);
                } else {
                  newSelection.remove(option);
                }
                onSelectionChange(newSelection);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
