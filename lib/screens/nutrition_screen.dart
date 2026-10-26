import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';

class Meal {
  Meal(this.name, this.kcal, this.eaten);
  final String name;
  final int kcal;
  bool eaten;
}

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  static const _goal = 2000;

  final List<Meal> _meals = [
    Meal('Oatmeal with Fruits', 450, true),
    Meal('Grilled Chicken Salad', 450, true),
    Meal('Salmon with Veggies', 450, false),
    Meal('Greek Yogurt', 150, false),
  ];

  int get _eaten =>
      _meals.where((m) => m.eaten).fold(0, (sum, m) => sum + m.kcal);

  Future<void> _logFood() async {
    final meal = await showDialog<Meal>(
      context: context,
      builder: (_) => const _AddMealDialog(),
    );
    if (meal != null && mounted) setState(() => _meals.add(meal));
  }

  @override
  Widget build(BuildContext context) {
    final eaten = _eaten;
    final left = _goal - eaten;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          const Text('Nutrition', style: AppText.title),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Calorie Goal', style: AppText.caption),
                const SizedBox(height: 4),
                Text('${formatNumber(_goal)} kcal',
                    style: AppText.title.copyWith(fontSize: 30)),
                const SizedBox(height: 12),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: (eaten / _goal).clamp(0.0, 1.0)),
                  duration: const Duration(milliseconds: 500),
                  builder: (_, v, __) => LinearProgressIndicator(
                    value: v,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.peach,
                    backgroundColor: AppColors.trackPeach,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  left >= 0
                      ? '${formatNumber(eaten)} eaten · ${formatNumber(left)} left'
                      : '${formatNumber(eaten)} eaten · ${formatNumber(-left)} over',
                  style: AppText.caption,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _MacroCard(label: 'Carbs', grams: 180, goal: 250, color: AppColors.peach),
              SizedBox(width: 10),
              _MacroCard(label: 'Protein', grams: 120, goal: 150, color: AppColors.mint),
              SizedBox(width: 10),
              _MacroCard(label: 'Fats', grams: 60, goal: 70, color: AppColors.mintDark),
            ],
          ),
          const SizedBox(height: 18),
          const Text("Today's Meals", style: AppText.heading),
          const SizedBox(height: 10),
          for (final m in _meals)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                onTap: () => setState(() => m.eaten = !m.eaten),
                child: Row(
                  children: [
                    const Icon(Icons.restaurant, color: AppColors.mintDark),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: AppText.body),
                          Text('${m.kcal} kcal', style: AppText.caption),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: m.eaten,
                      activeColor: AppColors.mintDark,
                      onChanged: (v) => setState(() => m.eaten = v ?? false),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
          PrimaryButton(
            label: 'Log Food',
            color: AppColors.peachDark,
            icon: Icons.add_rounded,
            onPressed: _logFood,
          ),
        ],
      ),
    );
  }
}

class _MacroCard extends StatelessWidget {
  const _MacroCard({
    required this.label,
    required this.grams,
    required this.goal,
    required this.color,
  });

  final String label;
  final int grams;
  final int goal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final pct = grams / goal;
    return Expanded(
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            SizedBox(
              width: 52,
              height: 52,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: pct,
                    strokeWidth: 6,
                    color: color,
                    backgroundColor: const Color(0xFFDCE9E3),
                  ),
                  Text('${(pct * 100).round()}%',
                      style: AppText.caption.copyWith(fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: AppText.caption),
            Text('$grams g', style: AppText.body),
          ],
        ),
      ),
    );
  }
}

class _AddMealDialog extends StatefulWidget {
  const _AddMealDialog();

  @override
  State<_AddMealDialog> createState() => _AddMealDialogState();
}

class _AddMealDialogState extends State<_AddMealDialog> {
  final _name = TextEditingController();
  final _kcal = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _kcal.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _name.text.trim();
    final kcal = int.tryParse(_kcal.text.trim());
    if (name.isEmpty || kcal == null || kcal <= 0) return;
    Navigator.of(context).pop(Meal(name, kcal, true));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log food'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _name,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Meal name'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _kcal,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(labelText: 'Calories (kcal)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Add')),
      ],
    );
  }
}
