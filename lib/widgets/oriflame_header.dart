import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class OriflameHeader extends StatelessWidget {
  const OriflameHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(child: _AssistantButton()),
                  SvgPicture.asset(
                    'assets/images/oriflame_wordmark.svg',
                    width: 104,
                    fit: BoxFit.contain,
                  ),
                  const Expanded(child: _CameraButton()),
                ],
              ),
            ),
            const _PageTabs(),
            Container(height: 1, color: AppColors.hairline),
          ],
        ),
      ),
    );
  }
}

class _AssistantButton extends StatelessWidget {
  const _AssistantButton();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 34,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 2,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.surface900,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        'assets/icons/oriflame_ai.svg',
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  // The green AI Chip
                  Positioned(
                    left: 20,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(3, 3, 6, 2),
                      decoration: BoxDecoration(
                        color: AppColors.aiBadge,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        'AI',
                        style: AppTextStyles.captionBold.copyWith(
                          fontSize: 11,
                          height: 1.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            const Text('Your Assistant', style: AppTextStyles.chromeLabel),
          ],
        ),
      ],
    );
  }
}

class _CameraButton extends StatelessWidget {
  const _CameraButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.only(top: 2),
          decoration: const BoxDecoration(
            color: AppColors.surface900,
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
        const SizedBox(height: 2),
        const Text('Camera', style: AppTextStyles.chromeLabel),
      ],
    );
  }
}

/// Smart Post / Library / Communities / Share&Win. Only the active tab is
/// coloured — the design shows no underline on this screen.
class _PageTabs extends StatelessWidget {
  const _PageTabs();

  static const List<String> _tabs = [
    'Smart Post',
    'Library',
    'Communities',
    'Share&Win',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final (i, tab) in _tabs.indexed)
            Text(
              tab,
              style: AppTextStyles.h7Bold.copyWith(
                fontSize: 15,
                height: 1.2,
                color: i == 0 ? AppColors.tabGreen : AppColors.text300,
              ),
            ),
        ],
      ),
    );
  }
}
