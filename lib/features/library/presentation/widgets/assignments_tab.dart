import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/status.dart';
import '../blocs/assignments/assignments_bloc.dart';
import '../blocs/assignments/assignments_event.dart';
import '../blocs/assignments/assignments_state.dart';
import '../../domain/models/assignment.dart';

class AssignmentsTab extends StatefulWidget {
  const AssignmentsTab({super.key});

  @override
  State<AssignmentsTab> createState() => _AssignmentsTabState();
}

class _AssignmentsTabState extends State<AssignmentsTab> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentsBloc>().add(const LoadAssignments());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentsBloc, AssignmentsState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());

          case Status.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message ?? 'Error al cargar asignaciones'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AssignmentsBloc>().add(const LoadAssignments());
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );

          case Status.success:
            if (state.assignments.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_outlined, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'No tienes contenido asignado',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tu psicólogo puede asignarte contenido',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem('Total', state.totalAssignments, Colors.blue),
                      _buildStatItem('Pendientes', state.pendingCount, Colors.orange),
                      _buildStatItem('Completadas', state.completedCount, Colors.green),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<AssignmentsBloc>().add(const LoadAssignments());
                    },
                    child: ListView.builder(
                      itemCount: state.assignments.length,
                      itemBuilder: (context, index) {
                        final assignment = state.assignments[index];
                        return _buildAssignmentCard(context, assignment);
                      },
                    ),
                  ),
                ),
              ],
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildStatItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildAssignmentCard(BuildContext context, Assignment assignment) {
    final content = assignment.content;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (content.displayImage.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.network(
                content.displayImage,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 160,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        content.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (assignment.isCompleted)
                      const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  ],
                ),
                if (assignment.notes != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.notes, size: 16, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            assignment.notes!,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  'Asignado: ${_formatDate(assignment.assignedDate)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                if (!assignment.isCompleted) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<AssignmentsBloc>().add(
                              CompleteAssignment(assignmentId: assignment.id),
                            );
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Marcar como completada'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
