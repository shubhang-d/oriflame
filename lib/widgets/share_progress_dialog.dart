import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ShareProgressDialog extends StatefulWidget {
  final VoidCallback onComplete;

  const ShareProgressDialog({super.key, required this.onComplete});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => ShareProgressDialog(
        onComplete: () {
          Navigator.of(context).pop();
          launchUrl(
            Uri.parse('https://www.instagram.com/oriflame/?hl=en'),
            mode: LaunchMode.externalApplication,
          );
        },
      ),
    );
  }

  @override
  State<ShareProgressDialog> createState() => _ShareProgressDialogState();
}

class _ShareProgressDialogState extends State<ShareProgressDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const List<String> _stages = [
    'Generating your sales link..',
    'Copying the caption to clipboard',
    'Saving the content to your profile',
    'Preparing the content for social media',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..forward().then((_) {
        if (mounted) {
          widget.onComplete();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full screen blur
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: const ColoredBox(
              color: Colors.black26,
            ),
          ),
        ),
        // Dialog box
        Center(
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 300, // Fixed width locks the horizontal size of the card
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo
                    SvgPicture.asset(
                      'assets/icons/oriflame_ai.svg',
                      width: 48,
                      height: 48,
                      colorFilter: const ColorFilter.mode(
                        AppColors.tabGreen,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stage text with fixed height to prevent card resizing vertically
                    Container(
                      height: 44,
                      alignment: Alignment.center,
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, _) {
                          final currentStage =
                              (_controller.value * _stages.length)
                                  .floor()
                                  .clamp(0, _stages.length - 1);
                          return Text(
                            _stages[currentStage],
                            style: AppTextStyles.captionBold.copyWith(
                              color: AppColors.text300,
                              fontSize: 14,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 220,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, _) {
                            return LinearProgressIndicator(
                              value: _controller.value,
                              minHeight: 6,
                              backgroundColor:
                                  AppColors.tabGreen.withValues(alpha: 0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.tabGreen),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ), // newly added closing parenthesis for SizedBox
          ),
        ),
      ],
    );
  }
}
