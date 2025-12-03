import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';

/// Forgot Password Page
///
/// TODO: Auth team - Implement complete forgot password functionality
/// This includes:
/// - Email validation
/// - Send reset password email
/// - Bloc/Cubit for state management
/// - Integration with forgot password service
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Auth team - Implement password reset logic
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Si el correo existe, recibirás un enlace para restablecer tu contraseña'),
              backgroundColor: green29,
            ),
          );

          // Navigate back to login
          context.pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green29),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Recuperar Contraseña',
          style: crimsonBold.copyWith(fontSize: 20, color: green29),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Icon
                Icon(
                  Icons.lock_reset_rounded,
                  size: 80,
                  color: green29.withOpacity(0.8),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  '¿Olvidaste tu contraseña?',
                  textAlign: TextAlign.center,
                  style: crimsonBold.copyWith(
                    fontSize: 24,
                    color: green29,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  'Ingresa tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
                  textAlign: TextAlign.center,
                  style: sourceSansRegular.copyWith(
                    fontSize: 16,
                    color: gray767,
                  ),
                ),

                const SizedBox(height: 40),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    labelStyle: sourceSansRegular.copyWith(color: gray767),
                    prefixIcon: const Icon(Icons.email_outlined, color: green29),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: grayD9),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: grayD9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: green29, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu correo electrónico';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Por favor ingresa un correo válido';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Reset Password Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleResetPassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: green29,
                    foregroundColor: white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(white),
                          ),
                        )
                      : Text(
                          'Enviar Enlace',
                          style: sourceSansBold.copyWith(
                            fontSize: 16,
                            color: white,
                          ),
                        ),
                ),

                const SizedBox(height: 24),

                // Back to Login
                TextButton(
                  onPressed: () => context.pop(),
                  child: Text(
                    'Volver al inicio de sesión',
                    style: sourceSansSemiBold.copyWith(
                      fontSize: 14,
                      color: green29,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
