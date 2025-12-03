import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/ui/theme.dart';
import 'core/navigation/app_navigation.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/data/services/auth_service.dart';
import 'features/auth/presentation/blocs/login/login_bloc.dart';
import 'features/auth/presentation/blocs/register/register_bloc.dart';
import 'features/home/presentation/blocs/home/home_bloc.dart';
import 'core/networking/http_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create auth repository singleton
    final authRepository = AuthRepositoryImpl(
      service: AuthService(
        httpClient: HttpClient(),
      ),
    );

    return MultiBlocProvider(
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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Soft Focus',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppNavigation.createRouter(),
      ),
    );
  }
}
