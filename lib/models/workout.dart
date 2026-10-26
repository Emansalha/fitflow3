import 'package:flutter/material.dart';

/// MEDIA: every `image` / `video` below is optional.
/// Use either a web link ('https://...jpg' / '.mp4') or a bundled file
/// ('assets/images/full_body.jpg' / 'assets/videos/squat.mp4').
/// Use only media you are licensed to use (see README).
const String? kOnboardingImage = 'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?q=80&w=1080&auto=format&fit=crop';

class Exercise {
  const Exercise(this.name, this.detail, [this.video]);
  final String name;
  final String detail;
  final String? video; // e.g. 'assets/videos/goblet_squat.mp4'
}

class Workout {
  const Workout({
    required this.title,
    required this.category,
    required this.minutes,
    required this.kcal,
    required this.level,
    required this.icon,
    required this.exercises,
    this.image,
    this.video,
  });

  final String title;
  final String category;
  final String level;
  final int minutes;
  final int kcal;
  final IconData icon;
  final List<Exercise> exercises;
  final String? image; // cover photo
  final String? video; // workout preview video
}

const kCategories = ['All', 'Strength', 'Cardio', 'Yoga', 'HIIT'];

const String kSampleVideoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

const kWorkouts = <Workout>[
  Workout(
    title: 'Full Body Strength',
    category: 'Strength',
    minutes: 45,
    kcal: 320,
    level: 'Intermediate',
    icon: Icons.fitness_center,
    image: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1000&auto=format&fit=crop',
    video: kSampleVideoUrl,
    exercises: [
      Exercise('Goblet Squat', '3 sets x 12 reps', kSampleVideoUrl),
      Exercise('Push Ups', '3 sets x 15 reps', kSampleVideoUrl),
      Exercise('Bent Over Row', '3 sets x 10 reps', kSampleVideoUrl),
      Exercise('Plank Hold', '3 sets x 45 sec', kSampleVideoUrl),
    ],
  ),
  Workout(
    title: 'HIIT Burn',
    category: 'HIIT',
    minutes: 25,
    kcal: 280,
    level: 'Advanced',
    icon: Icons.local_fire_department,
    image: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=1000&auto=format&fit=crop',
    video: kSampleVideoUrl,
    exercises: [
      Exercise('Burpees', '4 rounds x 30 sec', kSampleVideoUrl),
      Exercise('Mountain Climbers', '4 rounds x 30 sec', kSampleVideoUrl),
      Exercise('Jump Squats', '4 rounds x 30 sec', kSampleVideoUrl),
    ],
  ),
  Workout(
    title: 'Core Crusher',
    category: 'Strength',
    minutes: 30,
    kcal: 210,
    level: 'Beginner',
    icon: Icons.accessibility_new,
    image: 'https://images.unsplash.com/photo-1544033593-9bfe42ef7cd8?q=80&w=1000&auto=format&fit=crop',
    video: kSampleVideoUrl,
    exercises: [
      Exercise('Crunches', '3 sets x 20 reps', kSampleVideoUrl),
      Exercise('Russian Twist', '3 sets x 24 reps', kSampleVideoUrl),
      Exercise('Leg Raises', '3 sets x 12 reps', kSampleVideoUrl),
      Exercise('Side Plank', '2 sets x 30 sec', kSampleVideoUrl),
    ],
  ),
  Workout(
    title: 'Evening Run',
    category: 'Cardio',
    minutes: 35,
    kcal: 350,
    level: 'Intermediate',
    icon: Icons.directions_run,
    image: 'https://images.unsplash.com/photo-1502680390469-be75c86b636f?q=80&w=1000&auto=format&fit=crop',
    video: kSampleVideoUrl,
    exercises: [
      Exercise('Warm-up Walk', '5 min', kSampleVideoUrl),
      Exercise('Easy Pace Run', '5 km', kSampleVideoUrl),
      Exercise('Cool-down Walk', '5 min', kSampleVideoUrl),
    ],
  ),
  Workout(
    title: 'Morning Flow',
    category: 'Yoga',
    minutes: 20,
    kcal: 90,
    level: 'Beginner',
    icon: Icons.self_improvement,
    image: 'https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=1000&auto=format&fit=crop',
    video: kSampleVideoUrl,
    exercises: [
      Exercise('Sun Salutation', '5 rounds', kSampleVideoUrl),
      Exercise('Warrior Sequence', '2 min each side', kSampleVideoUrl),
      Exercise('Child Pose', '2 min', kSampleVideoUrl),
    ],
  ),
];
