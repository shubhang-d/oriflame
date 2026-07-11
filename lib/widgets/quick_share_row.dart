import 'package:flutter/material.dart';
import '../models/share_platform.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'platform_logo.dart';

class QuickShareRow extends StatelessWidget {
  final ValueChanged<SharePlatform> onShare;

  const QuickShareRow({super.key, required this.onShare});

  static const List<({SharePlatform platform, Color? ring})> _targets = [
    (platform: SharePlatform.instagram, ring: null),
    (platform: SharePlatform.instagram, ring: AppColors.brandInstagram),
    (platform: SharePlatform.facebook, ring: null),
    (platform: SharePlatform.facebook, ring: AppColors.brandFacebook),
    (platform: SharePlatform.messenger, ring: null),
    (platform: SharePlatform.tiktok, ring: null),
    (platform: SharePlatform.snapchat, ring: null),
    (platform: SharePlatform.x, ring: null),
    (platform: SharePlatform.youtube, ring: null),
    (platform: SharePlatform.whatsapp, ring: null),
    (platform: SharePlatform.telegram, ring: null),
    (platform: SharePlatform.linkedin, ring: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Quick share to:', style: AppTextStyles.captionBold),
        const SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _targets.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final target = _targets[index];
                return _BouncingLogo(
                  platform: target.platform,
                  ringColor: target.ring,
                  onTap: () => onShare(target.platform),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _BouncingLogo extends StatefulWidget {
  final SharePlatform platform;
  final Color? ringColor;
  final VoidCallback onTap;

  const _BouncingLogo({
    required this.platform,
    required this.ringColor,
    required this.onTap,
  });

  @override
  State<_BouncingLogo> createState() => _BouncingLogoState();
}

class _BouncingLogoState extends State<_BouncingLogo> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.82),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap();
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: PlatformLogo(
          platform: widget.platform,
          showRing: widget.ringColor != null,
          ringColor: widget.ringColor ?? AppColors.brandInstagram,
        ),
      ),
    );
  }
}
