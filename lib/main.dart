import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'screens/startup_flow.dart';

void main() {
  runApp(const ProviderScope(child: BrandieApp()));
}

class BrandieApp extends StatelessWidget {
  const BrandieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oriflame',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const StartupFlow(),
    );
  }
}
