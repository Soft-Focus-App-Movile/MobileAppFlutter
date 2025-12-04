import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'features/tracking/injection_container.dart' as di;
import 'features/tracking/presentation/bloc/tracking_bloc.dart';
import 'features/tracking/presentation/bloc/tracking_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MainApp());
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
            create: (context) => HomeBloc(),
          ),

          BlocProvider<TrackingBloc>(
            create: (context) => di.sl<TrackingBloc>()
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
