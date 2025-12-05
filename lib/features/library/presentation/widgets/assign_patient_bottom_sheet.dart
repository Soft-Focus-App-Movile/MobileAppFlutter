import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../therapy/domain/models/patient_directory_item.dart';

class AssignPatientBottomSheet extends StatefulWidget {
  final int selectedCount;
  final List<PatientDirectoryItem> patients;
  final bool isLoading;
  final String? errorMessage;
  final Function(String patientId, String patientName) onPatientSelected;
  final VoidCallback onDismiss;
  final VoidCallback onRetry;

  const AssignPatientBottomSheet({
    super.key,
    required this.selectedCount,
    required this.patients,
    required this.isLoading,
    this.errorMessage,
    required this.onPatientSelected,
    required this.onDismiss,
    required this.onRetry,
  });

  @override
  State<AssignPatientBottomSheet> createState() => _AssignPatientBottomSheetState();
}

class _AssignPatientBottomSheetState extends State<AssignPatientBottomSheet> {
  String _searchQuery = '';
  bool _showAllPatients = false;

  List<PatientDirectoryItem> get _recentPatients {
    return widget.patients.take(4).toList();
  }

  List<PatientDirectoryItem> get _filteredPatients {
    if (_searchQuery.isEmpty && !_showAllPatients) {
      return _recentPatients;
    } else if (_searchQuery.isEmpty) {
      return widget.patients;
    } else {
      return widget.patients.where((patient) {
        return patient.patientName.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: gray1C,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seleccione el Paciente',
                    style: sourceSansSemiBold.copyWith(
                      fontSize: 20,
                      color: white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.selectedCount} ${widget.selectedCount == 1 ? "contenido seleccionado" : "contenidos seleccionados"}',
                    style: sourceSansRegular.copyWith(
                      fontSize: 14,
                      color: gray828,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: widget.onDismiss,
                icon: const Icon(Icons.close, color: white),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_searchQuery.isEmpty && !_showAllPatients)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Pacientes Recientes',
                style: sourceSansSemiBold.copyWith(
                  fontSize: 16,
                  color: white,
                ),
              ),
            ),
          if (_showAllPatients || _searchQuery.isNotEmpty) ...[
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                  if (value.isNotEmpty) _showAllPatients = true;
                });
              },
              style: sourceSansRegular.copyWith(
                fontSize: 14,
                color: white,
              ),
              decoration: InputDecoration(
                hintText: 'Buscar paciente...',
                hintStyle: sourceSansRegular.copyWith(
                  fontSize: 14,
                  color: gray828,
                ),
                prefixIcon: const Icon(Icons.search, color: gray828),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.close, color: gray828),
                      )
                    : null,
                filled: true,
                fillColor: gray2C,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: green49),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (widget.isLoading)
            Container(
              height: 200,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: green49),
            )
          else if (widget.errorMessage != null)
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.errorMessage!,
                    style: sourceSansRegular.copyWith(
                      fontSize: 14,
                      color: gray828,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: widget.onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green49,
                    ),
                    child: const Text('Reintentar', style: TextStyle(color: black)),
                  ),
                ],
              ),
            )
          else if (_filteredPatients.isEmpty)
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Text(
                'No se encontraron pacientes',
                style: sourceSansRegular.copyWith(
                  fontSize: 14,
                  color: gray828,
                ),
              ),
            )
          else
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 400),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _filteredPatients.length + (_showAllPatients || _searchQuery.isNotEmpty || widget.patients.length <= 4 ? 0 : 1),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  if (index == _filteredPatients.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _showAllPatients = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gray2C,
                          foregroundColor: green49,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Buscar más pacientes',
                              style: sourceSansSemiBold.copyWith(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final patient = _filteredPatients[index];
                  return _PatientItem(
                    patient: patient,
                    onTap: () {
                      widget.onPatientSelected(patient.patientId, patient.patientName);
                      widget.onDismiss();
                    },
                  );
                },
              ),
            ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _PatientItem extends StatelessWidget {
  final PatientDirectoryItem patient;
  final VoidCallback onTap;

  const _PatientItem({
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: gray2C,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: gray808,
              backgroundImage: patient.profilePhotoUrl.isNotEmpty
                  ? NetworkImage(patient.profilePhotoUrl)
                  : null,
              child: patient.profilePhotoUrl.isEmpty
                  ? Text(
                      patient.patientName.isNotEmpty ? patient.patientName[0].toUpperCase() : 'P',
                      style: sourceSansSemiBold.copyWith(
                        fontSize: 18,
                        color: white,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.patientName,
                    style: sourceSansSemiBold.copyWith(
                      fontSize: 16,
                      color: white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${patient.age} años',
                    style: sourceSansRegular.copyWith(
                      fontSize: 13,
                      color: gray828,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
