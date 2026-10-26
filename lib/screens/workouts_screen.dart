import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/workout.dart';
import 'workout_detail_screen.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  String _category = 'All';
  String _query = '';

  List<Workout> get _filtered => kWorkouts.where((w) {
        final okCat = _category == 'All' || w.category == _category;
        final okQuery = w.title.toLowerCase().contains(_query.toLowerCase());
        return okCat && okQuery;
      }).toList();

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          const Text('Workouts', style: AppText.title),
          const SizedBox(height: 14),
          TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'Search workouts...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: kGlassFill,
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final c in kCategories)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: _category == c,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _category = c),
                      selectedColor: AppColors.mintDark,
                      backgroundColor: kGlassFill,
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: _category == c ? Colors.white : AppColors.ink,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 48),
              child: Center(child: Text('No workouts found', style: AppText.caption)),
            ),
          for (final w in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GlassCard(
                padding: const EdgeInsets.all(10),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => WorkoutDetailScreen(workout: w)),
                ),
                child: Row(
                  children: [
                    WorkoutArt(icon: w.icon, image: w.image, width: 96, height: 84),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(w.title, style: AppText.heading.copyWith(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text('${w.minutes} min · ${w.kcal} kcal', style: AppText.caption),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
