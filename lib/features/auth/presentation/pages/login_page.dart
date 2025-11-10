import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/api_constants.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/login/login_event.dart';
import '../blocs/login/login_state.dart';
import '../../domain/models/user_type.dart';

class LoginPage extends StatefulWidget {
  final Function() onLoginSuccess;
  final Function() onAdminLoginSuccess;
  final Function() onNavigateToRegister;
  final Function(String email, String fullName, String tempToken) onNavigateToRegisterWithOAuth;
  final Function() onNavigateToPendingVerification;

  const LoginPage({
    super.key,
    required this.onLoginSuccess,
    required this.onAdminLoginSuccess,
    required this.onNavigateToRegister,
    required this.onNavigateToRegisterWithOAuth,
    required this.onNavigateToPendingVerification,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          // Handle login success based on user type
          if (state is LoginSuccess) {
            final user = state.user;
            if (user.userType == UserType.ADMIN) {
              widget.onAdminLoginSuccess();
            } else {
              widget.onLoginSuccess();
            }
          }

          // Navigate to register with OAuth data
          if (state is LoginOAuthRegistrationRequired) {
            final oauthData = state.oauthData;
            widget.onNavigateToRegisterWithOAuth(
              oauthData.email,
              oauthData.fullName,
              oauthData.tempToken,
            );
            context.read<LoginBloc>().add(ClearOAuthDataRequested());
          }

          // Navigate to pending verification if psychologist is not verified
          if (state is LoginPsychologistPendingVerification) {
            widget.onNavigateToPendingVerification();
            context.read<LoginBloc>().add(ClearPendingVerificationRequested());
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),

                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(11),
                      child: Text(
                        'Iniciar Sesión',
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
                    width: 200,
                    height: 200,
                  ),

                  const SizedBox(height: 60),

                  // Email field
                  TextField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(EmailChanged(value));
                    },
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      hintText: 'Nombre de usuario',
                      hintStyle: sourceSansRegular.copyWith(color: gray828),
                      prefixIcon: Icon(Icons.person, color: green37),
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

                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    onChanged: (value) {
                      context.read<LoginBloc>().add(PasswordChanged(value));
                    },
                    enabled: !isLoading,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: '************',
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

                  const SizedBox(height: 24),

                  // Login button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: !isLoading &&
                              state.email.isNotEmpty &&
                              state.password.isNotEmpty
                          ? () {
                              context.read<LoginBloc>().add(LoginSubmitted());
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
                              'Iniciar Sesión',
                              style: sourceSansBold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Error message
                  if (state is LoginError)
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

                  // Divider with text
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: grayE0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'o continuar con',
                            style: sourceSansRegular.copyWith(
                              color: gray828,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: grayE0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Google button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: !isLoading
                          ? () {
                              context
                                  .read<LoginBloc>()
                                  .add(GoogleSignInRequested(ApiConstants.googleServerClientId));
                            }
                          : null,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: yellowEB,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppAssets.googleIcon,
                            width: 15,
                            height: 15,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Google',
                            style: sourceSansRegular.copyWith(
                              color: black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Register link
                  TextButton(
                    onPressed: widget.onNavigateToRegister,
                    child: RichText(
                      text: TextSpan(
                        text: 'No tienes cuenta? ',
                        style: sourceSansRegular.copyWith(
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: 'Regístrate',
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
}
