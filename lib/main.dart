import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'core/ui/theme.dart';
import 'core/navigation/app_navigation.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/blocs/login/login_bloc.dart';
import 'features/auth/presentation/blocs/register/register_bloc.dart';
import 'features/home/presentation/blocs/home/home_bloc.dart';
import 'features/therapy/data/repositories/therapy_repository_impl.dart';
import 'features/therapy/data/services/therapy_service.dart';
import 'core/networking/http_client.dart';
import 'core/utils/session_manager.dart';
import 'core/data/local/local_user_data_source.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'features/tracking/injection_container.dart' as tracking_di;
import 'features/tracking/presentation/bloc/tracking_bloc.dart';
import 'features/tracking/presentation/bloc/tracking_event.dart';
import 'features/notifications/injection_container.dart' as notifications_di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa el formato de fechas para español
  await initializeDateFormatting('es_ES', null);

  // Inicializar servicios core
  await _initCoreServices();
  
  // Inicializar tracking
  await tracking_di.init();
  
  // Inicializar notificaciones
  await notifications_di.init();

  runApp(const MainApp());
}

/// Inicializa servicios core que son compartidos por múltiples features
Future<void> _initCoreServices() async {
  final sl = GetIt.instance;
  
  // Registrar HttpClient como singleton
  if (!sl.isRegistered<HttpClient>()) {
    sl.registerLazySingleton(() => HttpClient());
  }
  
  // Registrar SessionManager como singleton
  if (!sl.isRegistered<SessionManager>()) {
    sl.registerLazySingleton(() => SessionManager.instance);
  }
  
  // Registrar LocalUserDataSource como singleton
  if (!sl.isRegistered<LocalUserDataSource>()) {
    sl.registerLazySingleton(() => LocalUserDataSource());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Create HTTP client singleton
    final httpClient = HttpClient();

    // Create auth repository singleton
    final authRepository = AuthRepositoryImpl(
      service: AuthService(
        httpClient: httpClient,
      ),
    );

    // Create therapy repository singleton
    final therapyRepository = TherapyRepositoryImpl(
      service: TherapyService(httpClient: httpClient),
    );

    // Create local user data source singleton
    final localUserDataSource = LocalUserDataSource();

    return ProviderScope(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginBloc(repository: authRepository),
          ),
          BlocProvider(
            create: (context) => RegisterBloc(repository: authRepository),
          ),
          BlocProvider(
            create: (context) => HomeBloc(
              therapyRepository: therapyRepository,
              localUserDataSource: localUserDataSource,
            ),
          ),
          BlocProvider<TrackingBloc>(
            create: (context) => tracking_di.sl<TrackingBloc>()
              ..add(LoadInitialDataEvent()), // Carga datos iniciales
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Soft Focus',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppNavigation.createRouter(),
        ),
      ),
    );
  }
}