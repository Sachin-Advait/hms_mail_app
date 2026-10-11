import 'package:enough_platform_widgets/enough_platform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/theme/app_colors.dart';
import '../config/theme/app_theme.dart';
import '../localization/extension.dart';
import '../routes/routes.dart';

/// Displays the welcome screen in the HMS onboarding style
class WelcomeScreen extends ConsumerStatefulWidget {
  /// Creates a [WelcomeScreen]
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final _pages = PageController();
  var _index = 0;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _signIn() => context.goNamed(Routes.accountAdd);

  @override
  Widget build(BuildContext context) {
    final localizations = ref.text;
    final slides = [
      (
        Icons.mark_email_unread_outlined,
        localizations.welcomePanel1Title,
        localizations.welcomePanel1Text,
      ),
      (
        Icons.alternate_email,
        localizations.welcomePanel2Title,
        localizations.welcomePanel2Text,
      ),
      (
        Icons.swipe_outlined,
        localizations.welcomePanel3Title,
        localizations.welcomePanel3Text,
      ),
      (
        Icons.cleaning_services_outlined,
        localizations.welcomePanel4Title,
        localizations.welcomePanel4Text,
      ),
    ];
    final last = _index == slides.length - 1;

    return PlatformScaffold(
      body: ColoredBox(
        color: AppColors.lightBackground,
        child: SafeArea(
          child: Column(
            children: [
              // ---------------------------------------------- Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 18, 6),
                child: Row(
                  children: [
                    Image.asset('assets/images/logo.png', height: 50),
                    const Spacer(),
                    AnimatedOpacity(
                      opacity: last ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: IgnorePointer(
                        ignoring: last,
                        child: TextButton(
                          onPressed: _signIn,
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.primary.withValues(
                              alpha: .08,
                            ),
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            localizations.actionSkip,
                            style: context.semiBold.copyWith(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ---------------------------------------------- Slides
              Expanded(
                child: PageView.builder(
                  controller: _pages,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemCount: slides.length,
                  itemBuilder: (context, i) => _Slide(
                    icon: slides[i].$1,
                    title: slides[i].$2,
                    body: slides[i].$3,
                  ),
                ),
              ),

              // ---------------------------------------- Dots + button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
                child: Row(
                  children: [
                    for (var i = 0; i < slides.length; i++)
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        margin: const EdgeInsetsDirectional.only(end: 6),
                        height: 7,
                        width: i == _index ? 26 : 7,
                        decoration: BoxDecoration(
                          color: i == _index
                              ? AppColors.primary
                              : AppColors.primary.withValues(alpha: .2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    const Spacer(),
                    SizedBox(
                      width: last ? 190 : 140,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: last
                            ? _signIn
                            : () => _pages.nextPage(
                                duration: Duration(
                                  milliseconds:
                                      MediaQuery.disableAnimationsOf(context)
                                      ? 0
                                      : 300,
                                ),
                                curve: Curves.easeOutCubic,
                              ),
                        iconAlignment: IconAlignment.end,
                        icon: Icon(last ? Icons.login : Icons.arrow_forward),
                        label: Text(
                          last
                              ? localizations.welcomeActionSignIn
                              : localizations.actionNext,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(22, 4, 22, 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExcludeSemantics(child: _Art(icon: icon)),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'HMS MAIL',
            style: context.semiBold.copyWith(
              fontSize: 10.5,
              color: AppColors.primary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: context.extraBold.copyWith(
            fontSize: 30,
            height: 1.18,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          body,
          style: context.regular.copyWith(
            fontSize: 15.5,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    ),
  );
}

/// The brand gradient card used by the HMS onboarding, with a mail icon.
class _Art extends StatelessWidget {
  const _Art({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(32));

    return Container(
      height: 260,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.secondary],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: Stack(
          children: [
            const Positioned(right: -50, top: -50, child: _Disc(size: 180)),
            const Positioned(left: -60, bottom: -70, child: _Disc(size: 190)),
            Center(
              child: Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: .14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .35),
                    width: 2,
                  ),
                ),
                child: Icon(icon, size: 52, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Disc extends StatelessWidget {
  const _Disc({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withValues(alpha: .07),
    ),
  );
}
