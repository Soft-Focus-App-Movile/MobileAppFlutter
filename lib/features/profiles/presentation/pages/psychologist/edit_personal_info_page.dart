import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../blocs/psychologist_profile/psychologist_profile_state.dart';
import '../../blocs/psychologist_profile/psychologist_profile_event.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final VoidCallback onNavigateBack;

  const EditPersonalInfoPage({
    super.key,
    required this.onNavigateBack,
  });

  @override
  State<EditPersonalInfoPage> createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  // Estados iniciales - Personal
  String _initialFirstName = '';
  String _initialLastName = '';
  String _initialDateOfBirth = '';

  // Estados iniciales - Profesional
  String _initialProfessionalBio = '';
  String _initialBusinessName = '';
  String _initialBusinessAddress = '';
  String _initialBankAccount = '';
  String _initialPaymentMethods = '';
  String _initialMaxPatientsCapacity = '';
  Set<String> _initialLanguages = {};
  Set<String> _initialTargetAudience = {};
  bool _initialIsAcceptingNewPatients = true;
  bool _initialIsProfileVisibleInDirectory = true;
  bool _initialAllowsDirectMessages = true;

  // Controladores actuales
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _professionalBioController;
  late TextEditingController _businessNameController;
  late TextEditingController _businessAddressController;
  late TextEditingController _bankAccountController;
  late TextEditingController _paymentMethodsController;
  late TextEditingController _maxPatientsCapacityController;

  // Estados actuales
  String _dateOfBirth = '';
  Set<String> _selectedLanguages = {};
  Set<String> _selectedTargetAudience = {};
  bool _isAcceptingNewPatients = true;
  bool _isProfileVisibleInDirectory = true;
  bool _allowsDirectMessages = true;

  bool _isInitialized = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _professionalBioController = TextEditingController();
    _businessNameController = TextEditingController();
    _businessAddressController = TextEditingController();
    _bankAccountController = TextEditingController();
    _paymentMethodsController = TextEditingController();
    _maxPatientsCapacityController = TextEditingController();

    // Cargar el perfil al iniciar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PsychologistProfileBloc>().add(LoadPsychologistProfile());
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _professionalBioController.dispose();
    _businessNameController.dispose();
    _businessAddressController.dispose();
    _bankAccountController.dispose();
    _paymentMethodsController.dispose();
    _maxPatientsCapacityController.dispose();
    super.dispose();
  }

  bool get _hasChanges {
    return _firstNameController.text != _initialFirstName ||
        _lastNameController.text != _initialLastName ||
        _dateOfBirth != _initialDateOfBirth ||
        _professionalBioController.text != _initialProfessionalBio ||
        _businessNameController.text != _initialBusinessName ||
        _businessAddressController.text != _initialBusinessAddress ||
        _bankAccountController.text != _initialBankAccount ||
        _paymentMethodsController.text != _initialPaymentMethods ||
        _maxPatientsCapacityController.text != _initialMaxPatientsCapacity ||
        _selectedLanguages != _initialLanguages ||
        _selectedTargetAudience != _initialTargetAudience ||
        _isAcceptingNewPatients != _initialIsAcceptingNewPatients ||
        _isProfileVisibleInDirectory != _initialIsProfileVisibleInDirectory ||
        _allowsDirectMessages != _initialAllowsDirectMessages;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth.isNotEmpty
          ? DateTime.tryParse(_dateOfBirth) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1900),
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
        _dateOfBirth = picked.toIso8601String();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Editar información Personal',
          style: crimsonSemiBold.copyWith(
            fontSize: 20,
            color: green37,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green37),
          onPressed: widget.onNavigateBack,
        ),
        backgroundColor: white,
        elevation: 0,
      ),
      body: BlocConsumer<PsychologistProfileBloc, PsychologistProfileState>(
        listener: (context, state) {
          if (state is PsychologistProfileSuccess) {
            final profile = state.profile;

            if (!_isInitialized && profile != null) {
              // Inicializar valores solo la primera vez
              setState(() {
                _isInitialized = true;

                // Personal
                _initialFirstName = profile.firstName ?? '';
                _initialLastName = profile.lastName ?? '';
                _initialDateOfBirth = profile.dateOfBirth ?? '';

                _firstNameController.text = _initialFirstName;
                _lastNameController.text = _initialLastName;
                _dateOfBirth = _initialDateOfBirth;

                // Profesional
                _initialProfessionalBio = profile.professionalBio ?? '';
                _initialBusinessName = profile.businessName ?? '';
                _initialBusinessAddress = profile.businessAddress ?? '';
                _initialBankAccount = profile.bankAccount ?? '';
                _initialPaymentMethods = profile.paymentMethods ?? '';
                _initialMaxPatientsCapacity = profile.maxPatientsCapacity?.toString() ?? '';
                _initialLanguages = (profile.languages ?? []).toSet();
                _initialTargetAudience = (profile.targetAudience ?? []).toSet();
                _initialIsAcceptingNewPatients = profile.isAcceptingNewPatients;
                _initialIsProfileVisibleInDirectory = profile.isProfileVisibleInDirectory;
                _initialAllowsDirectMessages = profile.allowsDirectMessages;

                _professionalBioController.text = _initialProfessionalBio;
                _businessNameController.text = _initialBusinessName;
                _businessAddressController.text = _initialBusinessAddress;
                _bankAccountController.text = _initialBankAccount;
                _paymentMethodsController.text = _initialPaymentMethods;
                _maxPatientsCapacityController.text = _initialMaxPatientsCapacity;
                _selectedLanguages = _initialLanguages;
                _selectedTargetAudience = _initialTargetAudience;
                _isAcceptingNewPatients = _initialIsAcceptingNewPatients;
                _isProfileVisibleInDirectory = _initialIsProfileVisibleInDirectory;
                _allowsDirectMessages = _initialAllowsDirectMessages;
              });
            } else if (_isSaving && profile != null) {
              // Actualizar valores iniciales después de guardar
              setState(() {
                _isSaving = false;

                // Personal
                _initialFirstName = profile.firstName ?? '';
                _initialLastName = profile.lastName ?? '';
                _initialDateOfBirth = profile.dateOfBirth ?? '';

                // Profesional
                _initialProfessionalBio = profile.professionalBio ?? '';
                _initialBusinessName = profile.businessName ?? '';
                _initialBusinessAddress = profile.businessAddress ?? '';
                _initialBankAccount = profile.bankAccount ?? '';
                _initialPaymentMethods = profile.paymentMethods ?? '';
                _initialMaxPatientsCapacity = profile.maxPatientsCapacity?.toString() ?? '';
                _initialLanguages = (profile.languages ?? []).toSet();
                _initialTargetAudience = (profile.targetAudience ?? []).toSet();
                _initialIsAcceptingNewPatients = profile.isAcceptingNewPatients;
                _initialIsProfileVisibleInDirectory = profile.isProfileVisibleInDirectory;
                _initialAllowsDirectMessages = profile.allowsDirectMessages;
              });

              // Mostrar mensaje de éxito solo cuando se guarda
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Perfil actualizado correctamente ✓'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }

          // Mostrar mensaje de error
          if (state is PsychologistProfileError) {
            setState(() {
              _isSaving = false;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                duration: const Duration(seconds: 3),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final profile = state is PsychologistProfileSuccess ? state.profile : null;
          final isLoading = state is PsychologistProfileLoading && profile == null;

          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: green37),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image with Camera Button
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: greenEB2,
                      ),
                      child: profile?.profileImageUrl != null
                          ? ClipOval(
                              child: Image.network(
                                profile!.profileImageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: white,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: white,
                            ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: green29,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Nombre y Apellido en la misma fila
                Row(
                  children: [
                    Expanded(
                      child: _buildEditableField(
                        label: 'Nombre',
                        controller: _firstNameController,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEditableField(
                        label: 'Apellido',
                        controller: _lastNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Fecha de Cumpleaños
                _buildDateOfBirthPicker(),
                const SizedBox(height: 16),

                // Contact Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contacto',
                      style: sourceSansRegular.copyWith(
                        fontSize: 16,
                        color: yellow7E,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildContactItem(Icons.email, profile?.email ?? ''),
                    const SizedBox(height: 8),
                    _buildContactItem(Icons.phone, profile?.phone ?? ''),
                    const SizedBox(height: 8),
                    _buildContactItem(Icons.chat, profile?.phone ?? 'Whatsapp'),
                  ],
                ),
                const SizedBox(height: 32),

                // ========== SECCIÓN PROFESIONAL ==========
                Text(
                  'Información Profesional',
                  style: crimsonSemiBold.copyWith(
                    fontSize: 20,
                    color: green37,
                  ),
                ),
                const SizedBox(height: 16),

                // Professional Bio
                _buildEditableField(
                  label: 'Descripción Profesional',
                  controller: _professionalBioController,
                  minLines: 3,
                  maxLines: null,
                  maxLength: 1000,
                ),
                const SizedBox(height: 16),

                // Languages Selection
                _buildChipSelectionField(
                  label: 'Idiomas',
                  options: const ['Español', 'Inglés', 'Francés', 'Portugués', 'Alemán', 'Italiano', 'Chino', 'Japonés'],
                  selectedOptions: _selectedLanguages,
                  onSelectionChange: (newSelection) {
                    setState(() {
                      _selectedLanguages = newSelection;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Target Audience Selection
                _buildChipSelectionField(
                  label: 'Público Objetivo',
                  options: const ['Adultos', 'Adolescentes', 'Niños', 'Parejas', 'Familias', 'Tercera Edad'],
                  selectedOptions: _selectedTargetAudience,
                  onSelectionChange: (newSelection) {
                    setState(() {
                      _selectedTargetAudience = newSelection;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Business Info
                _buildEditableField(
                  label: 'Nombre del Negocio',
                  controller: _businessNameController,
                  maxLength: 100,
                ),
                const SizedBox(height: 16),

                _buildEditableField(
                  label: 'Dirección del Consultorio',
                  controller: _businessAddressController,
                  maxLength: 200,
                ),
                const SizedBox(height: 16),

                // Payment Info
                _buildEditableField(
                  label: 'Cuenta Bancaria',
                  controller: _bankAccountController,
                  maxLength: 50,
                ),
                const SizedBox(height: 16),

                _buildEditableField(
                  label: 'Métodos de Pago',
                  controller: _paymentMethodsController,
                  maxLength: 200,
                ),
                const SizedBox(height: 16),

                // Max Patients Capacity
                _buildEditableField(
                  label: 'Capacidad Máxima de Pacientes',
                  controller: _maxPatientsCapacityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),

                // Checkboxes Section
                Column(
                  children: [
                    _buildCheckbox(
                      value: _isAcceptingNewPatients,
                      label: 'Aceptando nuevos pacientes',
                      onChanged: (value) {
                        setState(() {
                          _isAcceptingNewPatients = value ?? true;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildCheckbox(
                      value: _isProfileVisibleInDirectory,
                      label: 'Perfil visible en directorio',
                      onChanged: (value) {
                        setState(() {
                          _isProfileVisibleInDirectory = value ?? true;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildCheckbox(
                      value: _allowsDirectMessages,
                      label: 'Permitir mensajes directos',
                      onChanged: (value) {
                        setState(() {
                          _allowsDirectMessages = value ?? true;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Action Buttons
                FractionallySizedBox(
                  widthFactor: 0.8,
                  child: Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onNavigateBack,
                          style: OutlinedButton.styleFrom(
                            backgroundColor: greenEB2,
                            foregroundColor: black,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                          ),
                          child: Text(
                            'Cancelar',
                            style: sourceSansRegular.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Save Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _hasChanges ? _saveChanges : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellowCB9C,
                            foregroundColor: black,
                            disabledBackgroundColor: grayD9,
                            disabledForegroundColor: gray767,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                          ),
                          child: Text(
                            'Guardar',
                            style: sourceSansRegular.copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    int minLines = 1,
    int? maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 16,
            color: black,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          style: sourceSansRegular.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText ?? '-',
            hintStyle: sourceSansRegular.copyWith(
              fontSize: 14,
              color: gray767,
            ),
            filled: true,
            fillColor: greenEB2,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: green37, width: 2),
            ),
            counterText: maxLength != null ? '' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthPicker() {
    final displayDate = _dateOfBirth.isNotEmpty
        ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_dateOfBirth))
        : 'Seleccionar fecha';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Fecha de Cumpleaños',
          style: sourceSansRegular.copyWith(
            fontSize: 16,
            color: black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: displayDate),
          readOnly: true,
          onTap: () => _selectDate(context),
          style: sourceSansRegular,
          decoration: InputDecoration(
            filled: true,
            fillColor: greenEB2,
            suffixIcon: const Icon(Icons.calendar_today, color: black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: green37, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: yellow7E, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: sourceSansRegular.copyWith(
            fontSize: 14,
            color: yellow7E,
          ),
        ),
      ],
    );
  }

  Widget _buildChipSelectionField({
    required String label,
    required List<String> options,
    required Set<String> selectedOptions,
    required Function(Set<String>) onSelectionChange,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 16,
            color: black,
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
              label: Text(option, style: const TextStyle(fontSize: 14)),
              onSelected: (selected) {
                final newSelection = Set<String>.from(selectedOptions);
                if (selected) {
                  newSelection.add(option);
                } else {
                  newSelection.remove(option);
                }
                onSelectionChange(newSelection);
              },
              backgroundColor: greenEB2,
              selectedColor: green29,
              labelStyle: TextStyle(
                color: isSelected ? white : black,
              ),
              checkmarkColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required String label,
    required Function(bool?) onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: green29,
          checkColor: white,
        ),
        Text(
          label,
          style: sourceSansRegular.copyWith(
            fontSize: 16,
            color: black,
          ),
        ),
      ],
    );
  }

  void _saveChanges() {
    final hasPersonalChanges = _firstNameController.text != _initialFirstName ||
        _lastNameController.text != _initialLastName ||
        _dateOfBirth != _initialDateOfBirth;

    final hasProfessionalChanges = _professionalBioController.text != _initialProfessionalBio ||
        _businessNameController.text != _initialBusinessName ||
        _businessAddressController.text != _initialBusinessAddress ||
        _bankAccountController.text != _initialBankAccount ||
        _paymentMethodsController.text != _initialPaymentMethods ||
        _maxPatientsCapacityController.text != _initialMaxPatientsCapacity ||
        _selectedLanguages != _initialLanguages ||
        _selectedTargetAudience != _initialTargetAudience ||
        _isAcceptingNewPatients != _initialIsAcceptingNewPatients ||
        _isProfileVisibleInDirectory != _initialIsProfileVisibleInDirectory ||
        _allowsDirectMessages != _initialAllowsDirectMessages;

    if (hasPersonalChanges || hasProfessionalChanges) {
      setState(() {
        _isSaving = true;
      });

      context.read<PsychologistProfileBloc>().add(
            UpdatePsychologistProfile(
              firstName: hasPersonalChanges && _firstNameController.text.isNotEmpty
                  ? _firstNameController.text
                  : null,
              lastName: hasPersonalChanges && _lastNameController.text.isNotEmpty
                  ? _lastNameController.text
                  : null,
              dateOfBirth: hasPersonalChanges && _dateOfBirth.isNotEmpty
                  ? _dateOfBirth
                  : null,
              professionalBio: hasProfessionalChanges && _professionalBioController.text.isNotEmpty
                  ? _professionalBioController.text
                  : null,
              businessName: hasProfessionalChanges && _businessNameController.text.isNotEmpty
                  ? _businessNameController.text
                  : null,
              businessAddress: hasProfessionalChanges && _businessAddressController.text.isNotEmpty
                  ? _businessAddressController.text
                  : null,
              bankAccount: hasProfessionalChanges && _bankAccountController.text.isNotEmpty
                  ? _bankAccountController.text
                  : null,
              paymentMethods: hasProfessionalChanges && _paymentMethodsController.text.isNotEmpty
                  ? _paymentMethodsController.text
                  : null,
              maxPatientsCapacity: hasProfessionalChanges && _maxPatientsCapacityController.text.isNotEmpty
                  ? int.tryParse(_maxPatientsCapacityController.text)
                  : null,
              languages: hasProfessionalChanges && _selectedLanguages.isNotEmpty
                  ? _selectedLanguages.toList()
                  : null,
              targetAudience: hasProfessionalChanges && _selectedTargetAudience.isNotEmpty
                  ? _selectedTargetAudience.toList()
                  : null,
              isAcceptingNewPatients: hasProfessionalChanges ? _isAcceptingNewPatients : null,
              isProfileVisibleInDirectory: hasProfessionalChanges ? _isProfileVisibleInDirectory : null,
              allowsDirectMessages: hasProfessionalChanges ? _allowsDirectMessages : null,
            ),
          );
    }
  }
}
