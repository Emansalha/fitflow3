import 'dart:ui';

import 'package:flutter/material.dart';

import 'theme.dart';

/// Mint-to-peach page background.
class AppGradient extends StatelessWidget {
  const AppGradient({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mintLight,
            Color(0xFFF7EEE6),
            AppColors.peachLight,
            Color(0xFFFBC7A6),
          ],
          stops: [0, .4, .7, 1],
        ),
      ),
      child: child,
    );
  }
}

/// Frosted-glass card.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.radius = 20,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(radius);
    return ClipRRect(
      borderRadius: r,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: kGlassFill,
            borderRadius: r,
            border: Border.all(color: kGlassBorder),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: r,
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.mintDark,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expand ? double.infinity : null,
      height: 54,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            if (icon != null) ...[
              const SizedBox(width: 8),
              Icon(icon, size: 20),
            ],
          ],
        ),
      ),
    );
  }
}

/// Cover image (asset or network). Falls back to a gradient + icon.
class WorkoutArt extends StatelessWidget {
  const WorkoutArt({
    super.key,
    required this.icon,
    this.image,
    this.width,
    this.height,
    this.iconSize = 36,
    this.radius = 16,
  });

  final IconData icon;
  final String? image;
  final double? width;
  final double? height;
  final double iconSize;
  final double radius;

  Widget _placeholder() =>
      Center(child: Icon(icon, size: iconSize, color: AppColors.mintDark));

  Widget _photo(String src) {
    final fallback = _placeholder();
    Widget err(BuildContext _, Object __, StackTrace? ___) => fallback;
    if (src.startsWith('http')) {
      return Image.network(
        src,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: err,
        loadingBuilder: (c, child, p) => p == null ? child : fallback,
      );
    }
    return Image.asset(
      src,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: err,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFBFE8D6), Color(0xFFF9CDB5)],
        ),
      ),
      child: image == null ? _placeholder() : _photo(image!),
    );
  }
}

class Legend extends StatelessWidget {
  const Legend({super.key, required this.color, required this.label, required this.value});
  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: AppText.caption)),
          Text(value, style: AppText.body.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
