import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../blocs/register/register_bloc.dart';
import '../blocs/register/register_event.dart';
import '../blocs/register/register_state.dart';
import '../../domain/models/user.dart';
import '../../domain/models/user_type.dart';
import '../../domain/models/psychology_specialty.dart';

class RegisterPage extends StatefulWidget {
  final String? oauthEmail;
  final String? oauthFullName;
  final String? oauthTempToken;
  final Function(UserType) onRegisterSuccess;
  final Function(User) onAutoLogin;
  final Function() onNavigateToLogin;
  final Function() onNavigateToPendingVerification;

  const RegisterPage({
    super.key,
    this.oauthEmail,
    this.oauthFullName,
    this.oauthTempToken,
    required this.onRegisterSuccess,
    required this.onAutoLogin,
    required this.onNavigateToLogin,
    required this.onNavigateToPendingVerification,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  // Psychologist fields
  late TextEditingController _licenseNumberController;
  late TextEditingController _yearsOfExperienceController;
  late TextEditingController _regionController;
  late TextEditingController _universityController;
  late TextEditingController _graduationYearController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptedTerms = false;
  bool _hasOpenedPrivacyPolicy = false;
  bool _showPrivacyPolicyDialog = false;

  final Set<String> _selectedSpecialties = {};
  final bool _specialtiesExpanded = false;

  // Document URIs
  String? _licenseFile;
  String? _diplomaFile;
  String? _dniFile;
  String? _certificationsFile;

  bool _showUniversitySuggestions = false;

  @override
  void initState() {
    super.initState();

    // Parse OAuth full name
    final nameParts = widget.oauthFullName?.split(' ') ?? [];
    final firstName = nameParts.isNotEmpty ? nameParts.first : '';
    final lastName = nameParts.length > 1 ? nameParts.skip(1).join(' ') : '';

    _firstNameController = TextEditingController(text: firstName);
    _lastNameController = TextEditingController(text: lastName);
    _emailController = TextEditingController(text: widget.oauthEmail ?? '');
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _licenseNumberController = TextEditingController();
    _yearsOfExperienceController = TextEditingController();
    _regionController = TextEditingController();
    _universityController = TextEditingController();
    _graduationYearController = TextEditingController();

    // Set OAuth email in BLoC if provided
    if (widget.oauthEmail != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<RegisterBloc>().add(RegisterEmailChanged(widget.oauthEmail!));
      });
    }

    // Set OAuth temp token in BLoC if provided
    if (widget.oauthTempToken != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<RegisterBloc>().add(SetOAuthTempToken(widget.oauthTempToken!));
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _licenseNumberController.dispose();
    _yearsOfExperienceController.dispose();
    _regionController.dispose();
    _universityController.dispose();
    _graduationYearController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(String documentType) async {
    final result = await FilePicker.platform.pickFiles(
      type: documentType == 'dni' ? FileType.any : FileType.custom,
      allowedExtensions: documentType == 'dni' ? null : ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        switch (documentType) {
          case 'license':
            _licenseFile = file.path;
            break;
          case 'diploma':
            _diplomaFile = file.path;
            break;
          case 'dni':
            _dniFile = file.path;
            break;
          case 'certifications':
            _certificationsFile = file.path;
            break;
        }
      });
    }
  }

  void _showSpecialtiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final specialtiesList = PsychologySpecialty.values
                .map((e) => e.displayName)
                .toList();

            return AlertDialog(
              title: Text(
                'Selecciona tus especialidades',
                style: sourceSansBold.copyWith(fontSize: 18),
              ),
              content: SizedBox(
                height: 400,
                width: double.maxFinite,
                child: ListView.builder(
                  itemCount: specialtiesList.length,
                  itemBuilder: (context, index) {
                    final specialty = specialtiesList[index];
                    return CheckboxListTile(
                      value: _selectedSpecialties.contains(specialty),
                      onChanged: (isChecked) {
                        setDialogState(() {
                          if (isChecked == true) {
                            _selectedSpecialties.add(specialty);
                          } else {
                            _selectedSpecialties.remove(specialty);
                          }
                        });
                        setState(() {}); // Update parent state too
                      },
                      title: Text(
                        specialty,
                        style: sourceSansRegular.copyWith(fontSize: 14),
                      ),
                      activeColor: green49,
                      checkColor: Colors.white,
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    'Listo',
                    style: sourceSansBold.copyWith(color: green49),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openPrivacyPolicyDialog() {
    setState(() {
      _showPrivacyPolicyDialog = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Política de Privacidad',
          style: crimsonBold.copyWith(fontSize: 20, color: green29),
        ),
        content: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Text(
              'En SoftFocus, tu privacidad y seguridad son nuestra máxima prioridad.\n\n'
              '• Todas las conversaciones con nuestro asistente de IA están completamente encriptadas\n'
              '• No almacenamos fotografías originales del análisis de emociones\n'
              '• Todos los mensajes con tu psicólogo están protegidos por encriptación médica\n'
              '• Tus registros diarios y estados de ánimo son completamente privados\n'
              '• Utilizamos encriptación AES-256 para toda tu información\n'
              '• Nunca compartimos tus datos con terceros ni con fines comerciales\n\n'
              'Contacto: softfocusorg@gmail.com\n'
              'Atención 24/7: 952 280 745',
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: gray828,
                height: 1.4,
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                _showPrivacyPolicyDialog = false;
                _hasOpenedPrivacyPolicy = true;
              });
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: green29,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Entendido',
              style: sourceSansBold.copyWith(color: white),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          // Navigate on success - Regular registration (userId, email)
          if (state is RegisterSuccessRegular) {
            final userType = state.userType ?? 'GENERAL';
            if (userType == 'PSYCHOLOGIST') {
              widget.onNavigateToPendingVerification();
            } else {
              widget.onRegisterSuccess(
                userType == 'GENERAL' ? UserType.GENERAL : UserType.PSYCHOLOGIST,
              );
            }
          }

          // Navigate on success - OAuth registration (User with JWT token for auto-login)
          if (state is RegisterSuccessOAuth) {
            widget.onAutoLogin(state.user);
          }

          // Navigate to pending verification if psychologist registration is pending
          if (state is RegisterPsychologistPendingVerification) {
            widget.onNavigateToPendingVerification();
          }
        },
        builder: (context, state) {
          final isLoading = state is RegisterLoading;
          final userType = state.userType ?? 'GENERAL';

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),

                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Regístrate',
                        style: crimsonSemiBold.copyWith(
                          fontSize: 40,
                          color: green49,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 1),

                  // Logo
                  Image.asset(
                    AppAssets.softPandaBlack,
                    width: 150,
                    height: 150,
                  ),

                  const SizedBox(height: 24),

                  // First name and Last name in row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _firstNameController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText: 'Nombre',
                            hintStyle: sourceSansRegular.copyWith(color: gray828),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: green37),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _lastNameController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText: 'Apellido',
                            hintStyle: sourceSansRegular.copyWith(color: gray828),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: green37),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Email
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _emailController,
                        onChanged: (value) {
                          context.read<RegisterBloc>().add(RegisterEmailChanged(value));
                        },
                        enabled: !isLoading && widget.oauthEmail == null,
                        readOnly: widget.oauthEmail != null,
                        decoration: InputDecoration(
                          hintText: 'Correo',
                          hintStyle: sourceSansRegular.copyWith(color: gray828),
                          filled: widget.oauthEmail != null,
                          fillColor: widget.oauthEmail != null
                              ? grayE0.withOpacity(0.2)
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: grayE0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: grayE0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: green37),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: grayE0),
                          ),
                        ),
                      ),
                      if (state.emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 4),
                          child: Text(
                            state.emailError!,
                            style: sourceSansRegular.copyWith(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Only show password fields if not from OAuth
                  if (widget.oauthEmail == null) ...[
                    // Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _passwordController,
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(RegisterPasswordChanged(value));
                          },
                          enabled: !isLoading,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Contraseña',
                            hintStyle: sourceSansRegular.copyWith(color: gray828),
                            prefixIcon: Icon(Icons.lock, color: green37),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: green37,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: green37),
                            ),
                          ),
                        ),
                        if (state.passwordError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text(
                              state.passwordError!,
                              style: sourceSansRegular.copyWith(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Confirm Password
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _confirmPasswordController,
                          onChanged: (value) {
                            context.read<RegisterBloc>().add(RegisterConfirmPasswordChanged(value));
                          },
                          enabled: !isLoading,
                          obscureText: !_isConfirmPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Confirme su contraseña',
                            hintStyle: sourceSansRegular.copyWith(color: gray828),
                            prefixIcon: Icon(Icons.lock, color: green37),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: green37,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: green37),
                            ),
                          ),
                        ),
                        if (state.confirmPasswordError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text(
                              state.confirmPasswordError!,
                              style: sourceSansRegular.copyWith(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],

                  // User Type Switch
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: grayE0.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tipo de cuenta',
                              style: sourceSansBold.copyWith(
                                fontSize: 16,
                                color: gray828,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'General',
                              style: sourceSansRegular.copyWith(
                                fontSize: 14,
                                color: userType == 'GENERAL' ? green49 : gray828,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Switch(
                              value: userType == 'PSYCHOLOGIST',
                              onChanged: !isLoading
                                  ? (checked) {
                                      context.read<RegisterBloc>().add(
                                            RegisterUserTypeChanged(
                                              checked ? 'PSYCHOLOGIST' : 'GENERAL',
                                            ),
                                          );
                                    }
                                  : null,
                              activeThumbColor: green49,
                              activeTrackColor: green49.withOpacity(0.5),
                              inactiveThumbColor: gray828,
                              inactiveTrackColor: grayE0,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Psicólogo',
                              style: sourceSansRegular.copyWith(
                                fontSize: 14,
                                color: userType == 'PSYCHOLOGIST' ? green49 : gray828,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Psychologist fields
                  if (userType == 'PSYCHOLOGIST') ...[
                    // License number and Years of experience in row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _licenseNumberController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'Número de licencia',
                              hintStyle: sourceSansRegular.copyWith(color: gray828),
                              filled: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: green37),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _yearsOfExperienceController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Años de experiencia',
                              hintStyle: sourceSansRegular.copyWith(color: gray828),
                              filled: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: green37),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Specialties selector
                    GestureDetector(
                      onTap: !isLoading
                          ? () => _showSpecialtiesDialog(context)
                          : null,
                      child: AbsorbPointer(
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: _selectedSpecialties.isEmpty
                                ? 'Selecciona especialidades'
                                : '${_selectedSpecialties.length} seleccionada(s)',
                            hintStyle: sourceSansRegular.copyWith(
                              color: _selectedSpecialties.isEmpty
                                  ? gray828
                                  : Colors.black,
                            ),
                            filled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: grayE0),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Specialty chips
                    if (_selectedSpecialties.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _selectedSpecialties.map((specialty) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: green49.withOpacity(0.1),
                              border: Border.all(color: green37),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  specialty,
                                  style: sourceSansRegular.copyWith(
                                    fontSize: 13,
                                    color: gray828,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                GestureDetector(
                                  onTap: !isLoading
                                      ? () {
                                          setState(() {
                                            _selectedSpecialties.remove(specialty);
                                          });
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.close,
                                    size: 16,
                                    color: gray828,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // University with autocomplete
                    TextField(
                      controller: _universityController,
                      onChanged: (value) {
                        context.read<RegisterBloc>().add(SearchUniversities(value));
                        setState(() {
                          _showUniversitySuggestions = value.isNotEmpty;
                        });
                      },
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        hintText: 'Universidad',
                        hintStyle: sourceSansRegular.copyWith(color: gray828),
                        filled: false,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: grayE0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: grayE0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: green37),
                        ),
                      ),
                    ),

                    // University suggestions dropdown
                    if (_showUniversitySuggestions &&
                        state.universitySuggestions != null &&
                        state.universitySuggestions!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.universitySuggestions!.length > 5
                              ? 5
                              : state.universitySuggestions!.length,
                          itemBuilder: (context, index) {
                            final suggestion = state.universitySuggestions![index];
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _universityController.text = suggestion['name'];
                                  _regionController.text = suggestion['region'] ?? '';
                                  _showUniversitySuggestions = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  suggestion['name'],
                                  style: sourceSansRegular.copyWith(fontSize: 14),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Region and Graduation year in row
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _regionController,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              hintText: 'Región',
                              hintStyle: sourceSansRegular.copyWith(color: gray828),
                              filled: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: green37),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _graduationYearController,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Año de graduación',
                              hintStyle: sourceSansRegular.copyWith(color: gray828),
                              filled: false,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: grayE0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: green37),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Documents section
                    Text(
                      'Documentos',
                      style: sourceSansBold.copyWith(
                        fontSize: 16,
                        color: gray828,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Document pickers in 2x2 grid
                    Column(
                      children: [
                        // First row: License and Diploma
                        Row(
                          children: [
                            Expanded(
                              child: _buildDocumentCard(
                                'Licencia',
                                _licenseFile,
                                () => _pickFile('license'),
                                () {
                                  setState(() => _licenseFile = null);
                                },
                                isLoading,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDocumentCard(
                                'Diploma',
                                _diplomaFile,
                                () => _pickFile('diploma'),
                                () {
                                  setState(() => _diplomaFile = null);
                                },
                                isLoading,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Second row: DNI and Certifications
                        Row(
                          children: [
                            Expanded(
                              child: _buildDocumentCard(
                                'DNI',
                                _dniFile,
                                () => _pickFile('dni'),
                                () {
                                  setState(() => _dniFile = null);
                                },
                                isLoading,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDocumentCard(
                                'Certificaciones',
                                _certificationsFile,
                                () => _pickFile('certifications'),
                                () {
                                  setState(() => _certificationsFile = null);
                                },
                                isLoading,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],

                  // Terms checkbox with privacy policy
                  GestureDetector(
                    onTap: !isLoading
                        ? () {
                            _openPrivacyPolicyDialog();
                          }
                        : null,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _acceptedTerms,
                          onChanged: !isLoading && _hasOpenedPrivacyPolicy
                              ? (value) {
                                  setState(() {
                                    _acceptedTerms = value ?? false;
                                  });
                                }
                              : (_) {
                                  // Si intenta marcar sin haber abierto, mostrar diálogo
                                  if (!_hasOpenedPrivacyPolicy) {
                                    _openPrivacyPolicyDialog();
                                  }
                                },
                          activeColor: green29,
                          checkColor: white,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Acepto la política de privacidad',
                                style: sourceSansRegular.copyWith(
                                  fontSize: 14,
                                  color: _hasOpenedPrivacyPolicy ? gray828 : grayA0,
                                ),
                              ),
                              if (!_hasOpenedPrivacyPolicy)
                                Text(
                                  '(Toca para leer)',
                                  style: sourceSansRegular.copyWith(
                                    fontSize: 12,
                                    color: green37,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _canSubmit(state, isLoading, userType)
                          ? () {
                              if (userType == 'GENERAL') {
                                context.read<RegisterBloc>().add(
                                      RegisterGeneralUserSubmitted(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        acceptsPrivacyPolicy: _acceptedTerms,
                                      ),
                                    );
                              } else if (userType == 'PSYCHOLOGIST') {
                                final specialtiesString = _selectedSpecialties.join(',');
                                final certList = _certificationsFile != null
                                    ? [_certificationsFile!]
                                    : null;

                                context.read<RegisterBloc>().add(
                                      RegisterPsychologistSubmitted(
                                        firstName: _firstNameController.text,
                                        lastName: _lastNameController.text,
                                        professionalLicense: _licenseNumberController.text,
                                        yearsOfExperience:
                                            int.tryParse(_yearsOfExperienceController.text) ?? 0,
                                        collegiateRegion: _regionController.text,
                                        university: _universityController.text,
                                        graduationYear:
                                            int.tryParse(_graduationYearController.text) ?? 2020,
                                        acceptsPrivacyPolicy: _acceptedTerms,
                                        licenseDocumentUri: _licenseFile ?? '',
                                        diplomaDocumentUri: _diplomaFile ?? '',
                                        dniDocumentUri: _dniFile ?? '',
                                        specialties: specialtiesString.isNotEmpty
                                            ? specialtiesString
                                            : null,
                                        certificationDocumentUris: certList,
                                      ),
                                    );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green49,
                        disabledBackgroundColor: green49.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Registrar',
                              style: sourceSansBold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Error message
                  if (state is RegisterError)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  const SizedBox(height: 6),

                  // Login link
                  TextButton(
                    onPressed: widget.onNavigateToLogin,
                    child: RichText(
                      text: TextSpan(
                        text: 'Ya tienes cuenta? ',
                        style: sourceSansRegular.copyWith(
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: 'Iniciar Sesión',
                            style: sourceSansRegular.copyWith(
                              color: green49,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 13),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDocumentCard(
    String label,
    String? filePath,
    VoidCallback onTap,
    VoidCallback onRemove,
    bool isLoading,
  ) {
    final hasFile = filePath != null;

    return GestureDetector(
      onTap: !isLoading ? onTap : null,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: hasFile
              ? green49.withOpacity(0.1)
              : grayE0.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              hasFile ? Icons.description : Icons.description_outlined,
              size: 40,
              color: hasFile ? green49 : gray828,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: sourceSansRegular.copyWith(
                fontSize: 13,
                color: gray828,
              ),
              textAlign: TextAlign.center,
            ),
            if (hasFile) ...[
              const SizedBox(height: 4),
              GestureDetector(
                onTap: !isLoading ? onRemove : null,
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: gray828,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  bool _canSubmit(RegisterState state, bool isLoading, String userType) {
    if (isLoading) return false;
    if (_firstNameController.text.isEmpty) return false;
    if (_lastNameController.text.isEmpty) return false;
    if (state.email.isEmpty) return false;
    if (state.emailError != null) return false;
    if (!_acceptedTerms) return false;

    // Password validation (only if not OAuth)
    if (widget.oauthEmail == null) {
      if (state.password.isEmpty) return false;
      if (state.confirmPassword.isEmpty) return false;
      if (state.passwordError != null) return false;
      if (state.confirmPasswordError != null) return false;
    }

    // Psychologist-specific validation
    if (userType == 'PSYCHOLOGIST') {
      if (_licenseFile == null) return false;
      if (_diplomaFile == null) return false;
      if (_dniFile == null) return false;
      if (_licenseNumberController.text.isEmpty) return false;
      if (_regionController.text.isEmpty) return false;
      if (_universityController.text.isEmpty) return false;
      if (_yearsOfExperienceController.text.isEmpty) return false;
      if (_graduationYearController.text.isEmpty) return false;
    }

    return true;
  }
}
