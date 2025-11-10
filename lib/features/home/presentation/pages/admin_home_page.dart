import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';

/// Home screen for admin users
class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(const LoadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Soft Focus Admin',
          style: crimsonSemiBold.copyWith(color: green49, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: sourceSansRegular,
              ),
            );
          }

          // TODO: Implement Admin Home UI
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Admin Dashboard',
                  style: crimsonSemiBold.copyWith(fontSize: 28, color: green49),
                ),
                const SizedBox(height: 16),
                Text(
                  'Administrator Home',
                  style: sourceSansRegular.copyWith(fontSize: 16, color: gray828),
                ),
                const SizedBox(height: 32),
                Text(
                  'TODO: Implement features:',
                  style: sourceSansBold.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text('- User Management', style: sourceSansRegular),
                Text('- Psychologist Verification', style: sourceSansRegular),
                Text('- System Statistics', style: sourceSansRegular),
                Text('- Content Moderation', style: sourceSansRegular),
              ],
            ),
          );
        },
      ),
    );
  }
}
