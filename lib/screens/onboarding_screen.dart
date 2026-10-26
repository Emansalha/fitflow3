import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/workout.dart';
import 'main_shell.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _start(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _start(context),
                    child: const Text('Skip',
                        style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w700)),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: AppText.title.copyWith(fontSize: 36),
                                children: const [
                                  TextSpan(text: 'Your '),
                                  TextSpan(
                                    text: 'Fitness',
                                    style: TextStyle(color: AppColors.mintDark),
                                  ),
                                  TextSpan(text: ' Journey Starts Here'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Track workouts, stay consistent and become your best self.',
                              style: AppText.caption.copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.mintDark.withValues(alpha: 0.25),
                                blurRadius: 24,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(36),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                const WorkoutArt(
                                  icon: Icons.fitness_center,
                                  image: kOnboardingImage,
                                  iconSize: 64,
                                  radius: 36,
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.5),
                                      ],
                                      stops: const [0.6, 1.0],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  right: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.9),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.bolt, size: 14, color: AppColors.mintDark),
                                        SizedBox(width: 4),
                                        Text(
                                          'Pro Strength',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.ink,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Get Started',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => _start(context),
                ),
                const SizedBox(height: 14),
                GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 76,
                        height: 32,
                        child: Stack(
                          children: [
                            for (var i = 0; i < 3; i++)
                              Positioned(
                                left: i * 20.0,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor: const [
                                      AppColors.mint,
                                      AppColors.peach,
                                      AppColors.mintDark,
                                    ][i],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text('Join over 2M+ users', style: AppText.body),
                      ),
                      const Icon(Icons.add_circle_outline, color: AppColors.mintDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
