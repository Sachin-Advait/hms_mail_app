import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/material.dart';

import '../config/theme/app_colors.dart';

/// Displays the HMS logo while the app starts, like the HMS splash screen
class SplashScreen extends StatelessWidget {
  /// Creates a new [SplashScreen]
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => PlatformScaffold(
    body: ColoredBox(
      color: AppColors.lightBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
        ),
      ),
    ),
  );
}
