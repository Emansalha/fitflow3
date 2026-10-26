import 'dart:async';

import 'package:flutter/material.dart';

import '../core/theme.dart';
import '../core/widgets.dart';
import '../models/ad.dart';
import 'onboarding_screen.dart';

/// Shown before onboarding. Swipe, tap Next, or wait for auto-advance.
class AdsScreen extends StatefulWidget {
  const AdsScreen({super.key});

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  final _controller = PageController();
  Timer? _timer;
  int _page = 0;

  bool get _isLast => _page >= kAds.length - 1;

  @override
  void initState() {
    super.initState();
    if (kAds.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finish());
      return;
    }
    if (kAds.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: kAdSeconds), (_) {
        if (_isLast) {
          _timer?.cancel();
        } else {
          _goNext();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _goNext() => _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );

  void _finish() {
    _timer?.cancel();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  void _onNext() {
    if (_isLast) {
      _finish();
    } else {
      _timer?.cancel();
      _goNext();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kAds.isEmpty) return const AppGradient(child: Scaffold(backgroundColor: Colors.transparent));

    return AppGradient(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 12, 0),
                  child: TextButton(
                    onPressed: _finish,
                    child: const Text('Skip',
                        style: TextStyle(
                            color: AppColors.muted, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: kAds.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _AdCard(ad: kAds[i]),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < kAds.length; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _page ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _page ? AppColors.mintDark : AppColors.barIdle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                child: PrimaryButton(
                  label: _isLast ? 'Continue' : 'Next',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: _onNext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AdCard extends StatelessWidget {
  const _AdCard({required this.ad});
  final AdItem ad;

  Widget _image(String src) {
    Widget err(BuildContext _, Object __, StackTrace? ___) => const SizedBox.shrink();
    return src.startsWith('http')
        ? Image.network(src, fit: BoxFit.cover, errorBuilder: err)
        : Image.asset(src, fit: BoxFit.cover, errorBuilder: err);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2F9E78), Color(0xFFE9835A)],
              ),
            ),
          ),
          if (ad.image != null) _image(ad.image!),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Color(0x00000000), Color(0xB3000000)],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
              ),
              child: const Text('Ad',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink)),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ad.title,
                    style: AppText.title.copyWith(color: Colors.white)),
                const SizedBox(height: 6),
                Text(ad.subtitle,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
