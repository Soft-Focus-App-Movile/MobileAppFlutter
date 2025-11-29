import 'package:flutter/material.dart';
import 'package:flutter_app_softfocus/core/ui/colors.dart' as AppColors;
import 'package:flutter_app_softfocus/core/ui/text_styles.dart' as AppTextStyles;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/delivery_status.dart';
import '../blocs/notifications/notifications_bloc.dart';
import '../blocs/notifications/notifications_event.dart';
import '../blocs/notifications/notifications_state.dart';
import '../widgets/notification_item.dart';
import '../widgets/empty_notifications_view.dart';
import '../widgets/notifications_disabled_view.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.green49),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Notificaciones',
              style: AppTextStyles.crimsonSemiBold.copyWith(
                fontSize: 24,
                color: AppColors.green49,
              ),
            ),
            actions: [
              if (state.isRefreshing)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.green49,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: state.isRefreshing
                      ? AppColors.green49.withOpacity(0.4)
                      : AppColors.green49,
                ),
                onPressed: state.isRefreshing || state.isLoading
                    ? null
                    : () => context.read<NotificationsBloc>().add(
                          const RefreshNotifications(),
                        ),
              ),
              if (state.notifications.any((n) => n.isUnread))
                TextButton(
                  onPressed: () => context.read<NotificationsBloc>().add(
                        const MarkAllAsRead(),
                      ),
                  child: Text(
                    'Marcar todas',
                    style: AppTextStyles.sourceSansRegular.copyWith(
                      color: AppColors.green49,
                    ),
                  ),
                ),
            ],
          ),
          body: Column(
            children: [
              if (state.isRefreshing)
                const LinearProgressIndicator(
                  color: AppColors.green49,
                  backgroundColor: Color(0xFFE8F5E9),
                  minHeight: 2,
                )
              else
                const SizedBox(height: 2),
              _buildTabs(state),
              const Divider(color: Color(0xFFE0E0E0), height: 1),
              Expanded(
                child: _buildBody(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabs(NotificationsState state) {
    final unreadCount = state.notifications.where((n) => n.isUnread).length;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTab(
            index: 0,
            label: 'Todas',
            isSelected: _selectedTab == 0,
            onTap: () {
              setState(() => _selectedTab = 0);
              context.read<NotificationsBloc>().add(const FilterNotifications(null));
            },
          ),
          const SizedBox(width: 32),
          _buildTab(
            index: 1,
            label: 'No leídas',
            badge: unreadCount > 0 ? unreadCount : null,
            isSelected: _selectedTab == 1,
            onTap: () {
              setState(() => _selectedTab = 1);
              context.read<NotificationsBloc>().add(
                    const FilterNotifications(DeliveryStatus.delivered),
                  );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required int index,
    required String label,
    int? badge,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppTextStyles.sourceSansRegular.copyWith(
                  fontSize: 16,
                  color: isSelected ? AppColors.green49 : Colors.grey,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
              if (badge != null) ...[
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge > 99 ? '99+' : badge.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (isSelected) ...[
            const SizedBox(height: 4),
            Container(
              width: label == 'No leídas' ? 60 : 40,
              height: 3,
              color: AppColors.green49,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBody(NotificationsState state) {
    if (state.isLoading && state.notifications.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.green49),
      );
    }

    if (state.error != null) {
      return _buildErrorView(state.error!);
    }

    if (state.notifications.isEmpty) {
      return state.notificationsEnabled
          ? const EmptyNotificationsView()
          : const NotificationsDisabledView();
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.notifications.length,
      separatorBuilder: (context, index) => const Divider(
        color: Color(0xFFE0E0E0),
        height: 1,
      ),
      itemBuilder: (context, index) {
        final notification = state.notifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () => context.read<NotificationsBloc>().add(
                MarkNotificationAsRead(notification.id),
              ),
          onDelete: () => context.read<NotificationsBloc>().add(
                DeleteNotification(notification.id),
              ),
        );
      },
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Color(0xFFE53935),
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: AppTextStyles.sourceSansRegular.copyWith(
                fontSize: 16,
                color: const Color(0xFFE53935),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<NotificationsBloc>().add(
                    const LoadNotifications(),
                  ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green49,
              ),
              child: Text(
                'Reintentar',
                style: AppTextStyles.sourceSansRegular.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<NotificationsBloc>().add(const StopAutoRefresh());
    super.dispose();
  }
}