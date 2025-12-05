import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/data/remote/admin_service.dart';
import '../../features/admin/data/repositories/admin_repository_impl.dart';
import '../../features/admin/presentation/blocs/admin_users/admin_users_bloc.dart';
import '../../features/admin/presentation/blocs/verify_psychologist/verify_psychologist_bloc.dart';
import '../../features/admin/presentation/pages/admin_users_page.dart';
import '../../features/admin/presentation/pages/verify_psychologist_page.dart';
import '../constants/api_constants.dart';
import '../utils/session_manager.dart';
import 'route.dart';

// Create a configured Dio instance for admin
Dio _createDio() {
  final dio = Dio();
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  return dio;
}

/// Admin navigation graph.
/// Contains routes specific to ADMIN users:
/// - User management
/// - Psychologist verification
/// - System administration
List<RouteBase> adminRoutes() {
  return [
    // Admin Users List Screen
    GoRoute(
      path: AppRoute.adminUsers.path,
      name: 'admin_users',
      builder: (context, state) {
        final repository = AdminRepositoryImpl(
          AdminService(_createDio()),
        );

        return BlocProvider(
          create: (context) => AdminUsersBloc(repository),
          child: AdminUsersPage(
            onNavigateToVerify: (userId) {
              // Navigate with userId as path parameter, exactly like Kotlin
              context.push('${AppRoute.verifyPsychologist.path}/$userId');
            },
            onLogout: () async {
              await SessionManager.instance.logout();
              if (context.mounted) {
                context.go(AppRoute.login.path);
              }
            },
          ),
        );
      },
    ),

    // Verify Psychologist Screen
    GoRoute(
      path: '${AppRoute.verifyPsychologist.path}/:userId',
      name: 'verify_psychologist',
      builder: (context, state) {
        final userId = state.pathParameters['userId'] ?? '';

        if (userId.isEmpty) {
          return const Scaffold(
            body: Center(
              child: Text('Error: Usuario no especificado'),
            ),
          );
        }

        final repository = AdminRepositoryImpl(
          AdminService(_createDio()),
        );

        return BlocProvider(
          create: (context) => VerifyPsychologistBloc(repository),
          child: VerifyPsychologistPage(
            userId: userId,
            onNavigateBack: () {
              context.pop();
            },
          ),
        );
      },
    ),

    // Future admin-specific routes can be added here
    // Example:
    // GoRoute(path: AppRoute.SystemSettings.path) { ... }
    // GoRoute(path: AppRoute.Analytics.path) { ... }
  ];
}
