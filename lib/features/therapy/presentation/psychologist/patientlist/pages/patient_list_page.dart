import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/ui/colors.dart';
import '../../../../../../core/ui/text_styles.dart';
import '../blocs/patient_list_bloc.dart';
import '../blocs/patient_list_event.dart';
import '../blocs/patient_list_state.dart';
import '../widgets/patient_card.dart';

class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Pacientes',
          style: crimsonSemiBold.copyWith(
            fontSize: 32,
            color: green49,
          ),
        ),
        actions: [
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
      body: BlocBuilder<PatientListBloc, PatientListState>(
        builder: (context, state) {
          if (state is PatientListLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4B634B),
              ),
            );
          }

          if (state is PatientListError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: sourceSansRegular.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PatientListBloc>().add(LoadPatients());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: green49,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Reintentar',
                        style: sourceSansBold.copyWith(color: white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is PatientListLoaded) {
            if (state.patients.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Aún no tienes pacientes asignados.',
                    style: sourceSansRegular.copyWith(
                      color: const Color(0xFF8B8B8B),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: green49,
              onRefresh: () async {
                context.read<PatientListBloc>().add(RefreshPatients());
                // Esperar a que se complete la carga
                await context.read<PatientListBloc>().stream.firstWhere(
                      (state) =>
                          state is PatientListLoaded ||
                          state is PatientListError,
                    );
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.patients.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final patient = state.patients[index];
                  return PatientCard(
                    patient: patient,
                    onTap: () {
                      // TODO: Navigate to patient detail
                      // context.push('/patient-detail/${patient.id}');
                    },
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}