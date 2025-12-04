import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/ui/colors.dart';
import '../../../../../core/ui/text_styles.dart';
import '../../blocs/psychologist_profile/psychologist_profile_bloc.dart';
import '../../blocs/psychologist_profile/psychologist_profile_state.dart';
import '../../blocs/psychologist_profile/psychologist_profile_event.dart';

class ProfessionalDataPage extends StatefulWidget {
  final VoidCallback onNavigateBack;

  const ProfessionalDataPage({
    super.key,
    required this.onNavigateBack,
  });

  @override
  State<ProfessionalDataPage> createState() => _ProfessionalDataPageState();
}

class _ProfessionalDataPageState extends State<ProfessionalDataPage> {
  @override
  void initState() {
    super.initState();
    // Cargar el perfil al iniciar
    context.read<PsychologistProfileBloc>().add(LoadPsychologistProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(
          'Datos profesionales',
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
      body: BlocBuilder<PsychologistProfileBloc, PsychologistProfileState>(
        builder: (context, state) {
          if (state is PsychologistProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: green37),
            );
          }

          if (state is PsychologistProfileError) {
            return Center(
              child: Text(
                state.message,
                style: sourceSansRegular.copyWith(
                  fontSize: 16,
                  color: gray070,
                ),
              ),
            );
          }

          if (state is PsychologistProfileSuccess) {
            final profile = state.profile;

            if (profile == null) {
              return const Center(
                child: Text('No se pudo cargar el perfil'),
              );
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Professional Info Container
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: greenF2,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // License Number
                        _buildInfoField(
                          label: 'Número de licencia',
                          value: profile.licenseNumber,
                        ),
                        const SizedBox(height: 16),

                        // University
                        _buildInfoField(
                          label: 'Universidad',
                          value: profile.university ?? 'No especificado',
                        ),
                        const SizedBox(height: 16),

                        // Specialties
                        _buildInfoField(
                          label: 'Especialidades',
                          value: profile.specialties.isNotEmpty
                              ? profile.specialties.join(', ')
                              : 'No especificadas',
                        ),
                        const SizedBox(height: 16),

                        // Years of Experience
                        _buildInfoField(
                          label: 'Años de experiencia',
                          value: '${profile.yearsOfExperience} años',
                        ),
                      ],
                    ),
                  ),

                  // Diploma/Certificates Section
                  if (_hasCertificates(profile)) ...[
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diploma/certificados',
                          style: crimsonSemiBold.copyWith(
                            fontSize: 16,
                            color: green37,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: greenF2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (profile.licenseDocumentUrl != null)
                                _buildDocumentItem(
                                  '• Licenciatura en Psicología (${profile.graduationYear ?? ""})',
                                ),
                              if (profile.licenseDocumentUrl != null && profile.diplomaCertificateUrl != null)
                                const SizedBox(height: 8),
                              if (profile.diplomaCertificateUrl != null)
                                _buildDocumentItem(
                                  '• Diplomado en Psicoterapia Breve - PUCP (2021)',
                                ),
                              if (profile.diplomaCertificateUrl != null &&
                                  profile.additionalCertificatesUrls != null &&
                                  profile.additionalCertificatesUrls!.isNotEmpty)
                                const SizedBox(height: 8),
                              if (profile.additionalCertificatesUrls != null &&
                                  profile.additionalCertificatesUrls!.isNotEmpty)
                                _buildDocumentItem(
                                  '• Especialización en Mindfulness y Regulación Emocional - UNMSM (2023)',
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  bool _hasCertificates(dynamic profile) {
    return profile.diplomaCertificateUrl != null ||
        profile.licenseDocumentUrl != null ||
        (profile.additionalCertificatesUrls != null && profile.additionalCertificatesUrls!.isNotEmpty);
  }

  Widget _buildInfoField({
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: crimsonSemiBold.copyWith(
            fontSize: 16,
            color: black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: sourceSansSemiBold.copyWith(
            fontSize: 16,
            color: gray070,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentItem(String text) {
    return Text(
      text,
      style: sourceSansSemiBold.copyWith(
        fontSize: 14,
        color: gray070,
        height: 1.43,
      ),
    );
  }
}