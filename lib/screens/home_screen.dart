import 'package:flutter/material.dart';

import '../core/painters.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/workout.dart';
import 'workout_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onNavigate});
  final ValueChanged<int> onNavigate;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _bars = [0.4, 0.55, 0.9, 0.5, 0.65, 0.35, 0.45];
  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  int _day = 2;

  void _soon(String what) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('$what coming soon')));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hi, Alex', style: AppText.title),
                    SizedBox(height: 4),
                    Text('Ready to crush your goals?', style: AppText.caption),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Notifications',
                onPressed: () => _soon('Notifications'),
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const GlassCard(
            child: Row(
              children: [
                ActivityRings(
                  size: 112,
                  stroke: 12,
                  rings: [RingData(.75, AppColors.mint, AppColors.trackMint)],
                  center: Text('75%', style: AppText.heading),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Legend(color: AppColors.mint, label: 'Workout', value: '45 min'),
                      Legend(color: AppColors.peach, label: 'Calories', value: '520 kcal'),
                      Legend(color: AppColors.mintDark, label: 'Steps', value: '8,752'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Weekly Activity', style: AppText.body),
                const SizedBox(height: 12),
                SizedBox(
                  height: 112,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (var i = 0; i < _bars.length; i++)
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => setState(() => _day = i),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  height: 80 * _bars[i],
                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: i == _day ? AppColors.mint : AppColors.barIdle,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _days[i],
                                  style: AppText.caption.copyWith(
                                    fontWeight: i == _day ? FontWeight.w800 : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text('Quick Actions', style: AppText.heading),
          const SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.1,
            children: [
              _ActionTile(
                icon: Icons.play_circle_outline,
                label: 'Start Workout',
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => WorkoutDetailScreen(workout: kWorkouts.first),
                )),
              ),
              _ActionTile(
                icon: Icons.restaurant_outlined,
                label: 'Log Food',
                onTap: () => widget.onNavigate(3),
              ),
              _ActionTile(
                icon: Icons.monitor_weight_outlined,
                label: 'Body Stats',
                onTap: () => widget.onNavigate(2),
              ),
              _ActionTile(
                icon: Icons.emoji_events_outlined,
                label: 'Challenges',
                onTap: () => _soon('Challenges'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.mintDark),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: AppText.body.copyWith(fontSize: 13))),
        ],
      ),
    );
  }
}
