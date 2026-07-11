import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class BuildingSmartPostsScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const BuildingSmartPostsScreen({super.key, required this.onComplete});

  @override
  State<BuildingSmartPostsScreen> createState() =>
      _BuildingSmartPostsScreenState();
}

class _BuildingSmartPostsScreenState extends State<BuildingSmartPostsScreen> {
  /// Soft green used for the camera chip
  static const Color _green = Color(0xFF8FC9A2);
  static const Color _pendingRing = Color(0xFFC9C9C9);
  static const Color _pendingText = Color(0xFF9A9A9A);

  static const Duration _perStep = Duration(milliseconds: 900);

  static const List<String> _steps = [
    'Preparing popular content for you',
    'Crafting a caption to boost engagement',
    'Adding your personal referral link and code',
    'Finding trending songs on other social media',
  ];

  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_perStep, (t) {
      setState(() => _current++);
      if (_current >= _steps.length) {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) widget.onComplete();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allDone = _current >= _steps.length;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          _header(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Text(
                  'Building personalised\nSmart Posts for you!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h8Bold.copyWith(
                    fontSize: 19,
                    height: 1.3,
                    color: AppColors.text500,
                  ),
                ),
                const SizedBox(height: 34),
                SizedBox(
                  width: 246,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var i = 0; i < _steps.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          child: _StepRow(
                            label: _steps[i],
                            state: i < _current
                                ? _StepState.done
                                : i == _current
                                    ? _StepState.active
                                    : _StepState.pending,
                            green: _green,
                            pendingRing: _pendingRing,
                            pendingText: _pendingText,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                AnimatedOpacity(
                  opacity: allDone ? 1 : 0,
                  duration: const Duration(milliseconds: 350),
                  child: Text(
                    'All set! Get ready to share…',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.h8Bold.copyWith(
                      fontSize: 15,
                      color: AppColors.text500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// The loading-state header
  Widget _header() {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
              child: Row(
                children: [
                  const Expanded(child: SizedBox(height: 34)),
                  SvgPicture.asset(
                    'assets/images/oriflame_wordmark.svg',
                    width: 104,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: _green,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(7),
                        child: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final (i, tab) in const [
                    'Smart Post',
                    'Library',
                    'Communities',
                    'Share&Win',
                  ].indexed)
                    Text(
                      tab,
                      style: AppTextStyles.h7Bold.copyWith(
                        fontSize: 15,
                        height: 1.2,
                        color: i == 0 ? AppColors.tabGreen : AppColors.text500,
                      ),
                    ),
                ],
              ),
            ),
            Container(height: 1, color: AppColors.hairline),
          ],
        ),
      ),
    );
  }
}

enum _StepState { pending, active, done }

class _StepRow extends StatelessWidget {
  final String label;
  final _StepState state;
  final Color green;
  final Color pendingRing;
  final Color pendingText;

  const _StepRow({
    required this.label,
    required this.state,
    required this.green,
    required this.pendingRing,
    required this.pendingText,
  });

  @override
  Widget build(BuildContext context) {
    final done = state == _StepState.done;
    final active = state == _StepState.active;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: _indicator(),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.caption.copyWith(
              fontSize: 14,
              height: 1.3,
              fontWeight: done || active ? FontWeight.w600 : FontWeight.w400,
              color: done || active ? AppColors.text500 : pendingText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _indicator() {
    switch (state) {
      case _StepState.done:
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(color: green, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 12, color: AppColors.white),
        );
      case _StepState.active:
        return SizedBox(
          width: 18,
          height: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(green),
            backgroundColor: green.withValues(alpha: 0.18),
          ),
        );
      case _StepState.pending:
        return Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: pendingRing, width: 1.5),
          ),
        );
    }
  }
}
