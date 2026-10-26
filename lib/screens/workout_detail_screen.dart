import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/workout.dart';
import 'video_player_screen.dart';

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({super.key, required this.workout});
  final Workout workout;

  void _play(BuildContext context, String? source) {
    if (source == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No video yet. Add one in models/workout.dart'),
      ));
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => VideoPlayerScreen(source: source)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(workout.title, style: AppText.heading),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                WorkoutArt(
                  icon: workout.icon,
                  image: workout.image,
                  height: 200,
                  iconSize: 80,
                  radius: 24,
                ),
                Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Preview workout',
                    iconSize: 36,
                    color: AppColors.mintDark,
                    onPressed: () => _play(context, workout.video),
                    icon: const Icon(Icons.play_arrow_rounded),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _Stat(label: 'Duration', value: '${workout.minutes} min'),
                const SizedBox(width: 10),
                _Stat(label: 'Calories', value: '${workout.kcal} kcal'),
                const SizedBox(width: 10),
                _Stat(label: 'Level', value: workout.level),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Exercises', style: AppText.heading),
            const SizedBox(height: 10),
            for (var i = 0; i < workout.exercises.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.mintLight,
                        child: Text('${i + 1}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, color: AppColors.mintDark)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(workout.exercises[i].name, style: AppText.body),
                            Text(workout.exercises[i].detail, style: AppText.caption),
                          ],
                        ),
                      ),
                      if (workout.exercises[i].video != null)
                        IconButton(
                          tooltip: 'Play exercise video',
                          icon: const Icon(Icons.play_circle_fill_rounded,
                              color: AppColors.mintDark),
                          onPressed: () => _play(context, workout.exercises[i].video),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: PrimaryButton(
              label: 'Start Workout',
              color: AppColors.mint,
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${workout.title} started. Good luck!')),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Text(label, style: AppText.caption),
            const SizedBox(height: 4),
            Text(value,
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
