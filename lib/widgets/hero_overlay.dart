import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ReadyToShareTag extends StatelessWidget {
  final String label;

  const ReadyToShareTag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/icons/Tag.png',
      scale: 0.9,
    );
  }
}

class PostCounterPill extends StatelessWidget {
  final int index;
  final int total;

  const PostCounterPill({super.key, required this.index, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.surface900.withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text('${index + 1} of $total', style: AppTextStyles.caption),
    );
  }
}

/// The vertical dots
class PageDots extends StatelessWidget {
  final int index;
  final int total;

  const PageDots({super.key, required this.index, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.surface700.withOpacity(0.3),
          borderRadius: BorderRadius.circular(24)),
      width: 24,
      height: 68,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < total; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.5),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == index
                        ? AppColors.green.withOpacity(0.7)
                        : AppColors.white.withValues(alpha: 0.85),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Creator avatar + "Ready to share" pill + the community performance line.
class HeroHeadline extends StatelessWidget {
  final String avatarAsset;
  final String badgeLabel;
  final String communityLine;

  const HeroHeadline({
    super.key,
    required this.avatarAsset,
    required this.badgeLabel,
    required this.communityLine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: ClipOval(child: Image.asset(avatarAsset, fit: BoxFit.cover)),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadyToShareTag(label: badgeLabel),
              const SizedBox(height: 4),
              Text(
                communityLine,
                style: AppTextStyles.h8Bold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
