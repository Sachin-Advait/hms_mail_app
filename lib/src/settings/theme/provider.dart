import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app_lifecycle/provider.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_theme.dart';
import '../provider.dart';
import 'model.dart';

part 'provider.g.dart';

/// The default color provider, the HMS brand colour
@Riverpod(keepAlive: true)
Color defaultColorSeed(DefaultColorSeedRef ref) => AppColors.primary;

/// Provides the settings
@Riverpod(keepAlive: true)
class ThemeFinder extends _$ThemeFinder {
  @override
  ThemeSettingsData build({required BuildContext context}) {
    final themeSettings = ref.watch(
      settingsProvider.select((value) => value.themeSettings),
    );
    ref.watch(appIsResumedProvider);
    final defaultColor = ref.watch(defaultColorSeedProvider);

    return _fromThemeSettings(themeSettings, defaultColor, context: context);
  }

  /// The mail app always uses the HMS light theme so it looks the same as
  /// the HMS app it will be merged into.
  static ThemeSettingsData _fromThemeSettings(
    ThemeSettings settings,
    Color defaultColor, {
    BuildContext? context,
  }) {
    final theme = _hmsMailTheme;

    return ThemeSettingsData(
      brightness: Brightness.light,
      lightTheme: theme,
      darkTheme: theme,
      themeMode: ThemeMode.light,
      cupertinoTheme: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.lightBackground,
        barBackgroundColor: AppColors.lightBackground,
        textTheme: const CupertinoTextThemeData(
          primaryColor: AppColors.primary,
          textStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  static final ThemeData _hmsMailTheme = AppTheme.light.copyWith(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: AppColors.cardBackground,
    ),
    listTileTheme: const ListTileThemeData(
      iconColor: AppColors.primary,
      selectedColor: AppColors.primary,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.primary.withValues(alpha: .08),
      side: BorderSide.none,
      labelStyle: const TextStyle(color: AppColors.primary),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.primary),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),
  );
}
