import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/connect_psychologist/connect_psychologist_bloc.dart';
import '../../blocs/connect_psychologist/connect_psychologist_event.dart';
import '../../blocs/connect_psychologist/connect_psychologist_state.dart';

class ConnectPsychologistPage extends StatefulWidget {
  final VoidCallback onNavigateBack;
  final VoidCallback onConnectionSuccess;
  final VoidCallback? onSearchPsychologists;

  const ConnectPsychologistPage({
    super.key,
    required this.onNavigateBack,
    required this.onConnectionSuccess,
    this.onSearchPsychologists,
  });

  @override
  State<ConnectPsychologistPage> createState() => _ConnectPsychologistPageState();
}

class _ConnectPsychologistPageState extends State<ConnectPsychologistPage> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Conectar con Psicólogo',
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
      body: BlocConsumer<ConnectPsychologistBloc, ConnectPsychologistState>(
        listener: (context, state) {
          if (state is ConnectPsychologistSuccess) {
            widget.onConnectionSuccess();
          }
        },
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: yellowE8,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: yellowCB9C.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                      left: 80,
                      right: 16,
                      top: 40,
                      bottom: 16,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Tienes código de tu psicólogo?',
                          style: sourceSansRegular.copyWith(
                            fontSize: 12,
                            color: yellow7E,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _codeController,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 8,
                          enabled: state is! ConnectPsychologistLoading,
                          decoration: InputDecoration(
                            hintText: 'Ingresa código aquí',
                            hintStyle: crimsonSemiBold.copyWith(
                              fontSize: 15,
                              color: white,
                            ),
                            filled: true,
                            fillColor: yellowB5,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            counterText: '',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                          style: sourceSansRegular.copyWith(
                            fontSize: 11,
                            color: white,
                          ),
                          onChanged: (value) {
                            if (value.length <= 8) {
                              _codeController.value = _codeController.value.copyWith(
                                text: value.toUpperCase(),
                                selection: TextSelection.collapsed(
                                  offset: value.length,
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          child: FractionallySizedBox(
                            widthFactor: 0.7,
                            child: ElevatedButton(
                              onPressed: state is! ConnectPsychologistLoading &&
                                      _codeController.text.isNotEmpty
                                  ? () {
                                      context.read<ConnectPsychologistBloc>().add(
                                            ConnectWithCodeRequested(
                                              _codeController.text,
                                            ),
                                          );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: yellowD8,
                                disabledBackgroundColor: grayD9,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                elevation: 0,
                              ),
                              child: state is ConnectPsychologistLoading
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        color: black,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Conectar',
                                      style: sourceSansRegular.copyWith(
                                        fontSize: 12,
                                        color: black,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        if (state is ConnectPsychologistError) ...[
                          const SizedBox(height: 4),
                          Text(
                            state.message,
                            style: sourceSansRegular.copyWith(
                              fontSize: 10,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                        const SizedBox(height: 6),
                        TextButton(
                          onPressed: widget.onSearchPsychologists,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 24),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            '¿No tienes código? Busca psicólogos aquí',
                            style: sourceSansRegular.copyWith(
                              fontSize: 10,
                              color: yellow7E,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: -70,
                    top: -20,
                    child: Image.asset(
                      'assets/images/jiraff_focus.png',
                      width: 250,
                      height: 250,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            color: green49.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.psychology,
                            size: 100,
                            color: green37,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
