import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'screens/ads_screen.dart';

void main() => runApp(const FitFlowApp());

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitFlow',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const AdsScreen(),
    );
  }
}
