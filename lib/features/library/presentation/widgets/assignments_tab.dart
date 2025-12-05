import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/common/status.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../blocs/assignments/assignments_bloc.dart';
import '../blocs/assignments/assignments_event.dart';
import '../blocs/assignments/assignments_state.dart';
import '../../domain/models/assignment.dart';
import '../pages/content_detail_page.dart';

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
            return const Center(child: CircularProgressIndicator(color: green49));

          case Status.failure:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    state.message ?? 'Error al cargar asignaciones',
                    style: sourceSansRegular.copyWith(fontSize: 14, color: white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AssignmentsBloc>().add(const LoadAssignments());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green49,
                      foregroundColor: white,
                    ),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );

          case Status.success:
            if (state.assignments.isEmpty) {
              return Center(
                child: Text(
                  'No tienes contenido asignado',
                  style: sourceSansRegular.copyWith(
                    fontSize: 14,
                    color: white.withOpacity(0.7),
                  ),
                ),
              );
            }

            final movieAssignments = state.assignments
                .where((a) => a.content.isMovie)
                .toList();
            final musicAssignments = state.assignments
                .where((a) => a.content.isMusic)
                .toList();
            final videoAssignments = state.assignments
                .where((a) => a.content.isVideo)
                .toList();

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (movieAssignments.isNotEmpty) ...[
                  Text(
                    'Películas asignadas',
                    style: sourceSansBold.copyWith(fontSize: 18, color: white),
                  ),
                  const SizedBox(height: 8),
                  ...movieAssignments.map((assignment) =>
                      _buildAssignmentCard(context, assignment)),
                  const SizedBox(height: 8),
                ],
                if (musicAssignments.isNotEmpty) ...[
                  Text(
                    'Música asignada',
                    style: sourceSansBold.copyWith(fontSize: 18, color: white),
                  ),
                  const SizedBox(height: 8),
                  ...musicAssignments.map((assignment) =>
                      _buildAssignmentCard(context, assignment)),
                  const SizedBox(height: 8),
                ],
                if (videoAssignments.isNotEmpty) ...[
                  Text(
                    'Videos asignados',
                    style: sourceSansBold.copyWith(fontSize: 18, color: white),
                  ),
                  const SizedBox(height: 8),
                  ...videoAssignments.map((assignment) =>
                      _buildAssignmentCard(context, assignment)),
                ],
              ],
            );

          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildAssignmentCard(BuildContext context, Assignment assignment) {
    final content = assignment.content;
    final dateFormat = DateFormat('dd/MM/yy');

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: gray1C,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          if (content.isMusic) {
            final musicUrl = content.spotifyUrl ?? content.externalUrl;
            if (musicUrl != null) {
              final uri = Uri.parse(musicUrl);
              if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No se pudo abrir Spotify')),
                  );
                }
              }
            }
          } else {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContentDetailPage(content: content),
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: content.posterImage,
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100,
                      height: 150,
                      color: gray828,
                      child: const Center(
                        child: CircularProgressIndicator(color: green49),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 100,
                      height: 150,
                      color: gray828,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              content.title,
                              style: sourceSansSemiBold.copyWith(
                                fontSize: 16,
                                color: white,
                                height: 1.25,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  _getTypeLabel(content.type),
                                  style: sourceSansRegular.copyWith(
                                    fontSize: 12,
                                    color: gray828,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (content.duration != null) ...[
                                  Text(
                                    ' • ',
                                    style: sourceSansRegular.copyWith(
                                      fontSize: 12,
                                      color: gray828,
                                    ),
                                  ),
                                  Text(
                                    content.formattedDuration!,
                                    style: sourceSansRegular.copyWith(
                                      fontSize: 12,
                                      color: gray828,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Asignado: ${dateFormat.format(assignment.assignedDate)}',
                              style: sourceSansRegular.copyWith(
                                fontSize: 11,
                                color: gray828,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (assignment.isCompleted) ...[
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    color: greenEB2,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Completado: ${assignment.completedDate != null ? dateFormat.format(assignment.completedDate!) : ""}',
                                    style: sourceSansRegular.copyWith(
                                      fontSize: 11,
                                      color: greenEB2,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (content.isMusic) {
                                  final musicUrl = content.spotifyUrl ?? content.externalUrl;
                                  if (musicUrl != null) {
                                    final uri = Uri.parse(musicUrl);
                                    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('No se pudo abrir Spotify')),
                                        );
                                      }
                                    }
                                  }
                                } else {
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ContentDetailPage(content: content),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: green65,
                                foregroundColor: greenF2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                minimumSize: const Size(0, 36),
                              ),
                              child: Text(
                                'Ver',
                                style: sourceSansSemiBold.copyWith(
                                  fontSize: 13,
                                  color: greenF2,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          if (!assignment.isCompleted) ...[
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<AssignmentsBloc>().add(
                                        CompleteAssignment(
                                            assignmentId: assignment.id),
                                      );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  foregroundColor: greenF2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  minimumSize: const Size(0, 36),
                                ),
                                child: Text(
                                  'Completar',
                                  style: sourceSansSemiBold.copyWith(
                                    fontSize: 13,
                                    color: greenF2,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'movie':
        return 'Película';
      case 'music':
        return 'Música';
      case 'video':
        return 'Video';
      default:
        return type;
    }
  }
}
