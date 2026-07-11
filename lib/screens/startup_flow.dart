import 'package:flutter/material.dart';
import 'building_smart_posts_screen.dart';
import 'smart_posts_screen.dart';

class StartupFlow extends StatefulWidget {
  const StartupFlow({super.key});

  @override
  State<StartupFlow> createState() => _StartupFlowState();
}

class _StartupFlowState extends State<StartupFlow> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 650),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: _loading
          ? BuildingSmartPostsScreen(
              key: const ValueKey('building'),
              onComplete: () {
                if (mounted) setState(() => _loading = false);
              },
            )
          : const SmartPostsScreen(key: ValueKey('feed')),
    );
  }
}
