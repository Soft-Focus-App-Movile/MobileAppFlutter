import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/colors.dart' as AppColors;
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;
import '../../data/mappers/notification_mapper.dart';
import '../../domain/entities/notification.dart' as domain;
import '../../domain/entities/notification_type.dart';
import '../../domain/entities/priority.dart';

class NotificationItem extends StatefulWidget {
  final domain.Notification notification;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _isExpanded = false;
  bool _showDeleteDialog = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.notification.isRead
          ? Colors.white
          : const Color(0xFFF5F9F5),
      child: InkWell(
        onTap: () {
          setState(() => _isExpanded = !_isExpanded);
          if (!_isExpanded) {
            widget.onTap();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcon(),
              const SizedBox(width: 12),
              Expanded(child: _buildContent()),
              IconButton(
                icon: const Icon(Icons.close, size: 20, color: Colors.grey),
                onPressed: () => setState(() => _showDeleteDialog = true),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: _getNotificationColor().withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getNotificationIcon(),
        color: _getNotificationColor(),
        size: 20,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.notification.title,
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 16,
                  fontWeight: widget.notification.isUnread
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: const Color(0xFF2C2C2C),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (widget.notification.priority == Priority.high ||
                widget.notification.priority == Priority.critical) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.notification.priority == Priority.critical ? '!' : 'Alta',
                  style: AppTextStyles.sourceSansRegular.copyWith(
                    fontSize: 9,
                    color: const Color(0xFFE53935),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            const SizedBox(width: 8),
            Text(
              NotificationMapper.formatTimeAgo(widget.notification.createdAt),
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.notification.content,
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 14,
                  color: const Color(0xFF5C5C5C),
                  height: 1.4,
                ),
                maxLines: _isExpanded ? null : 1,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              if (!_isExpanded && widget.notification.content.length > 120) ...[
                const SizedBox(height: 4),
                Text(
                  'Ver más',
                  style: AppTextStyles.sourceSansRegular.copyWith(
                    fontSize: 12,
                    color: AppColors.green49,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          const Divider(color: Color(0xFFE0E0E0), thickness: 0.5),
          const SizedBox(height: 4),
          Text(
            'Recibida el ${NotificationMapper.formatDateTime(widget.notification.createdAt)}',
            style: AppTextStyles.sourceSansRegular.copyWith(
              fontSize: 12,
              color: Colors.grey.withOpacity(0.7),
            ),
          ),
        ],
      ],
    );
  }

  Color _getNotificationColor() {
    switch (widget.notification.type) {
      case NotificationType.info:
        return const Color(0xFF1E88E5);
      case NotificationType.alert:
        return const Color(0xFFFB8C00);
      case NotificationType.warning:
        return const Color(0xFFF57C00);
      case NotificationType.emergency:
        return const Color(0xFFE53935);
      case NotificationType.checkinReminder:
        return AppColors.green49;
      case NotificationType.crisisAlert:
        return const Color(0xFFE53935);
      case NotificationType.messageReceived:
        return const Color(0xFF1E88E5);
      case NotificationType.assignmentDue:
        return const Color(0xFFFB8C00);
      case NotificationType.appointmentReminder:
        return const Color(0xFF8E24AA);
      case NotificationType.systemUpdate:
        return const Color(0xFF546E7A);
    }
  }

  IconData _getNotificationIcon() {
    switch (widget.notification.type) {
      case NotificationType.info:
      case NotificationType.systemUpdate:
        return Icons.info;
      case NotificationType.alert:
      case NotificationType.warning:
        return Icons.warning;
      case NotificationType.emergency:
      case NotificationType.crisisAlert:
        return Icons.error;
      case NotificationType.checkinReminder:
        return Icons.check_circle;
      case NotificationType.messageReceived:
        return Icons.email;
      case NotificationType.assignmentDue:
        return Icons.assignment;
      case NotificationType.appointmentReminder:
        return Icons.event;
    }
  }
}
