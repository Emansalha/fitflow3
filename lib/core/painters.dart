import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'theme.dart';

class RingData {
  const RingData(this.progress, this.color, this.track);
  final double progress;
  final Color color;
  final Color track;
}

/// Animated concentric activity rings.
class ActivityRings extends StatelessWidget {
  const ActivityRings({
    super.key,
    required this.rings,
    this.size = 110,
    this.stroke = 10,
    this.center,
  });

  final List<RingData> rings;
  final double size;
  final double stroke;
  final Widget? center;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOutCubic,
            builder: (_, t, __) => CustomPaint(
              size: Size.square(size),
              painter: _RingsPainter(rings, stroke, t),
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  _RingsPainter(this.rings, this.stroke, this.t);
  final List<RingData> rings;
  final double stroke;
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);
    for (var i = 0; i < rings.length; i++) {
      final r = size.width / 2 - stroke / 2 - i * (stroke + 5);
      if (r <= 0) break;
      canvas.drawCircle(
        c,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..color = rings[i].track,
      );
      canvas.drawArc(
        Rect.fromCircle(center: c, radius: r),
        -math.pi / 2,
        2 * math.pi * math.min(1.0, rings[i].progress) * t,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.round
          ..color = rings[i].color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingsPainter old) => old.t != t || old.rings != rings;
}

/// Smooth area chart for a list of values.
class AreaChart extends StatelessWidget {
  const AreaChart({super.key, required this.values, this.height = 140});
  final List<double> values;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(painter: _AreaPainter(values)),
    );
  }
}

class _AreaPainter extends CustomPainter {
  _AreaPainter(this.values);
  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2) return;
    final maxV = values.reduce(math.max) * 1.1;
    final dx = size.width / (values.length - 1);
    final pts = <Offset>[
      for (var i = 0; i < values.length; i++)
        Offset(i * dx, size.height - (values[i] / maxV) * size.height - 4),
    ];

    final line = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (var i = 1; i < pts.length; i++) {
      final midX = (pts[i - 1].dx + pts[i].dx) / 2;
      line.cubicTo(midX, pts[i - 1].dy, midX, pts[i].dy, pts[i].dx, pts[i].dy);
    }

    final fill = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fill,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0x80E9835A), Color(0x00E9835A)],
        ).createShader(Offset.zero & size),
    );
    canvas.drawPath(
      line,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round
        ..color = AppColors.peach,
    );
    canvas.drawCircle(pts.last, 5, Paint()..color = AppColors.peachDark);
  }

  @override
  bool shouldRepaint(_AreaPainter old) => old.values != values;
}
