import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';

/// Home screen for general users
class GeneralHomePage extends StatefulWidget {
  const GeneralHomePage({super.key});

  @override
  State<GeneralHomePage> createState() => _GeneralHomePageState();
}

class _GeneralHomePageState extends State<GeneralHomePage> {
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
          'Soft Focus',
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

          // TODO: Implement General Home UI
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Soft Focus',
                  style: crimsonSemiBold.copyWith(fontSize: 28, color: green49),
                ),
                const SizedBox(height: 16),
                Text(
                  'General User Home',
                  style: sourceSansRegular.copyWith(fontSize: 16, color: gray828),
                ),
                const SizedBox(height: 32),
                Text(
                  'TODO: Implement features:',
                  style: sourceSansBold.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 8),
                Text('- Welcome Card', style: sourceSansRegular),
                Text('- Tracking', style: sourceSansRegular),
                Text('- Recommendations Carousel', style: sourceSansRegular),
                Text('- Quick Actions', style: sourceSansRegular),
              ],
            ),
          );
        },
      ),
    );
  }
}
