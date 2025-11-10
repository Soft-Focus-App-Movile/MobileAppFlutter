import 'package:flutter/material.dart';
import '../../../../core/ui/colors.dart';
import '../../../../core/ui/text_styles.dart';
import '../../../../core/constants/app_assets.dart';

/// Screen shown to psychologists whose account is pending verification.
/// This is a simple informational screen - documents were already uploaded during registration.
class AccountReviewPage extends StatelessWidget {
  const AccountReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              greenC1,
              green49,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tu cuenta está\nsiendo revisada',
                style: crimsonSemiBold.copyWith(
                  fontSize: 40,
                  color: Colors.white,
                  height: 0.95,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Image.asset(
                AppAssets.pandaSoft,
                width: 550,
                height: 550,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
