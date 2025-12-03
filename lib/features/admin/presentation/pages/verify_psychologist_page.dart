import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../domain/models/psychologist_detail.dart';
import '../blocs/verify_psychologist/verify_psychologist_bloc.dart';
import '../blocs/verify_psychologist/verify_psychologist_event.dart';
import '../blocs/verify_psychologist/verify_psychologist_state.dart';

class VerifyPsychologistPage extends StatefulWidget {
  final String userId;
  final VoidCallback onNavigateBack;

  const VerifyPsychologistPage({
    super.key,
    required this.userId,
    required this.onNavigateBack,
  });

  @override
  State<VerifyPsychologistPage> createState() => _VerifyPsychologistPageState();
}

class _VerifyPsychologistPageState extends State<VerifyPsychologistPage> {
  final TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context
        .read<VerifyPsychologistBloc>()
        .add(LoadPsychologistDetail(widget.userId));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyPsychologistBloc, VerifyPsychologistState>(
      listener: (context, state) {
        if (state is VerifyPsychologistSuccess) {
          widget.onNavigateBack();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: widget.onNavigateBack,
                      icon: const Icon(Icons.arrow_back, color: green49),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Verificar Psicólogo',
                      style: crimsonSemiBold.copyWith(
                        fontSize: 24,
                        color: green49,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<VerifyPsychologistBloc,
                    VerifyPsychologistState>(
                  builder: (context, state) {
                    if (state is VerifyPsychologistLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: green49),
                      );
                    }

                    if (state is VerifyPsychologistError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            state.message,
                            style:
                                sourceSansRegular.copyWith(color: Colors.red),
                          ),
                        ),
                      );
                    }

                    if (state is VerifyPsychologistLoaded) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _InfoSection(
                              title: 'Información Personal',
                              child: Column(
                                children: [
                                  _InfoRow('Nombre completo',
                                      state.psychologist.fullName),
                                  _InfoRow('Email', state.psychologist.email),
                                  if (state.psychologist.phone != null)
                                    _InfoRow('Teléfono',
                                        state.psychologist.phone!),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _InfoSection(
                              title: 'Información Profesional',
                              child: Column(
                                children: [
                                  _InfoRow('Licencia',
                                      state.psychologist.licenseNumber),
                                  _InfoRow('Colegio Profesional',
                                      state.psychologist.professionalCollege),
                                  if (state.psychologist.collegeRegion != null)
                                    _InfoRow('Región Colegial',
                                        state.psychologist.collegeRegion!),
                                  if (state.psychologist.university != null)
                                    _InfoRow('Universidad',
                                        state.psychologist.university!),
                                  if (state.psychologist.graduationYear != null)
                                    _InfoRow('Año de Graduación',
                                        state.psychologist.graduationYear.toString()),
                                  _InfoRow(
                                      'Años de Experiencia',
                                      state.psychologist.yearsOfExperience
                                          .toString()),
                                  if (state.psychologist.specialties.isNotEmpty) ...[
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Especialidades:',
                                        style: sourceSansBold.copyWith(
                                          fontSize: 14,
                                          color: black,
                                        ),
                                      ),
                                    ),
                                    ...state.psychologist.specialties
                                        .map((specialty) => Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 4),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '• ${specialty.name}',
                                                  style:
                                                      sourceSansRegular.copyWith(
                                                    fontSize: 14,
                                                    color: gray828,
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            _InfoSection(
                              title: 'Documentos',
                              child: _DocumentsSection(
                                psychologist: state.psychologist,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _notesController,
                              decoration: InputDecoration(
                                labelText: 'Notas (opcional)',
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: grayE0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: green37),
                                ),
                              ),
                              maxLines: 3,
                              onChanged: (value) {
                                context
                                    .read<VerifyPsychologistBloc>()
                                    .add(UpdateNotes(value));
                              },
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<VerifyPsychologistBloc,
            VerifyPsychologistState>(
          builder: (context, state) {
            if (state is! VerifyPsychologistLoaded) {
              return const SizedBox.shrink();
            }

            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: state.isProcessing
                          ? null
                          : () {
                              context
                                  .read<VerifyPsychologistBloc>()
                                  .add(const RejectPsychologist());
                            },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(color: Colors.red),
                      ),
                      child: Text(
                        'Rechazar',
                        style: sourceSansBold.copyWith(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state.isProcessing
                          ? null
                          : () {
                              context
                                  .read<VerifyPsychologistBloc>()
                                  .add(const ApprovePsychologist());
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green49,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: state.isProcessing
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Aprobar',
                              style: sourceSansBold.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _InfoSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: crimsonSemiBold.copyWith(
                fontSize: 18,
                color: green49,
              ),
            ),
            const Divider(color: grayE0),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: sourceSansBold.copyWith(
                fontSize: 14,
                color: black,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: gray828,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentsSection extends StatelessWidget {
  final PsychologistDetail psychologist;

  const _DocumentsSection({required this.psychologist});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasDocuments = psychologist.licenseDocumentUrl != null ||
        psychologist.diplomaCertificateUrl != null ||
        psychologist.identityDocumentUrl != null ||
        (psychologist.additionalCertificatesUrls?.isNotEmpty ?? false);

    if (!hasDocuments) {
      return Text(
        'Este psicólogo se registró vía OAuth y no ha subido documentos aún.',
        style: sourceSansRegular.copyWith(
          fontSize: 14,
          color: gray828,
        ),
      );
    }

    return Column(
      children: [
        if (psychologist.licenseDocumentUrl != null)
          _DocumentButton(
            text: 'Ver Licencia Profesional',
            onPressed: () => _openUrl(psychologist.licenseDocumentUrl!),
          ),
        if (psychologist.diplomaCertificateUrl != null) ...[
          const SizedBox(height: 8),
          _DocumentButton(
            text: 'Ver Diploma',
            onPressed: () => _openUrl(psychologist.diplomaCertificateUrl!),
          ),
        ],
        if (psychologist.identityDocumentUrl != null) ...[
          const SizedBox(height: 8),
          _DocumentButton(
            text: 'Ver DNI',
            onPressed: () => _openUrl(psychologist.identityDocumentUrl!),
          ),
        ],
        if (psychologist.additionalCertificatesUrls?.isNotEmpty ?? false)
          ...psychologist.additionalCertificatesUrls!.map((url) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _DocumentButton(
                  text: 'Ver Certificado Adicional',
                  onPressed: () => _openUrl(url),
                ),
              )),
      ],
    );
  }
}

class _DocumentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _DocumentButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: green37,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: sourceSansRegular.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
