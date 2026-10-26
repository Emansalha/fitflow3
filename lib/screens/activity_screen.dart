import 'package:flutter/material.dart';

import '../core/painters.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

enum Range { day, week, month }

const _kcal = <Range, List<double>>{
  Range.day: [120, 340, 220, 480, 310, 560, 420],
  Range.week: [310, 420, 380, 520, 450, 610, 480],
  Range.month: [2100, 2450, 2300, 2750, 2600],
};

const _labels = <Range, List<String>>{
  Range.day: ['6a', '9a', '12p', '3p', '6p', '9p', '12a'],
  Range.week: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  Range.month: ['W1', 'W2', 'W3', 'W4', 'W5'],
};

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  Range _range = Range.week;

  @override
  Widget build(BuildContext context) {
    final values = _kcal[_range]!;
    final labels = _labels[_range]!;
    final total = values.fold<double>(0, (a, b) => a + b);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 120),
        children: [
          const Text('Activity', style: AppText.title),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<Range>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: Range.day, label: Text('Day')),
                ButtonSegment(value: Range.week, label: Text('Week')),
                ButtonSegment(value: Range.month, label: Text('Month')),
              ],
              selected: {_range},
              onSelectionChanged: (s) => setState(() => _range = s.first),
              style: SegmentedButton.styleFrom(
                backgroundColor: kGlassFill,
                foregroundColor: AppColors.ink,
                selectedBackgroundColor: AppColors.mintDark,
                selectedForegroundColor: Colors.white,
                side: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Calories Burned', style: AppText.caption),
                const SizedBox(height: 4),
                Text('${formatNumber(total)} kcal',
                    style: AppText.title.copyWith(fontSize: 30)),
                const SizedBox(height: 12),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: AreaChart(key: ValueKey(_range), values: values),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [for (final l in labels) Text(l, style: AppText.caption)],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const GlassCard(
            child: Row(
              children: [
                ActivityRings(
                  size: 120,
                  stroke: 11,
                  rings: [
                    RingData(.87, AppColors.peach, AppColors.trackPeach),
                    RingData(.66, AppColors.mint, AppColors.trackMint),
                    RingData(.75, AppColors.mintDark, Color(0xFFDCE9E3)),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Legend(color: AppColors.peach, label: 'Move', value: '520 / 600'),
                      Legend(color: AppColors.mint, label: 'Exercise', value: '40 / 60 min'),
                      Legend(color: AppColors.mintDark, label: 'Stand', value: '9 / 12 hr'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Steps', style: AppText.body),
                    Text('8,752 / 10,000', style: AppText.caption),
                  ],
                ),
                const SizedBox(height: 10),
                TweenAnimationBuilder<double>(
                  tween: Tween(end: 0.8752),
                  duration: const Duration(milliseconds: 800),
                  builder: (_, v, __) => LinearProgressIndicator(
                    value: v,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.mint,
                    backgroundColor: AppColors.trackMint,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
