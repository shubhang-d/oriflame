import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/share_platform.dart';

class PlatformLogo extends StatelessWidget {
  final SharePlatform platform;

  final double size;
  final Color backgroundColor;
  final bool showRing;
  final Color ringColor;
  final double ringWidth;
  final double ringGap;

  const PlatformLogo({
    super.key,
    required this.platform,
    this.size = 32,
    this.backgroundColor = const Color(0x33FFFFFF),
    this.showRing = false,
    this.ringColor = const Color(0xFFEC4899),
    this.ringWidth = 2,
    this.ringGap = 2,
  });

  static const Color _snapchatYellow = Color(0xFFFFFC00);

  static const double _glyphRatio = 0.7;

  @override
  Widget build(BuildContext context) {
    final band = ringWidth + ringGap;
    final fillDiameter = size - 2 * band;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showRing) ...[
            Container(
              width: size + 0.5,
              height: size + 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ringColor, width: ringWidth),
              ),
            ),
            Container(
              width: fillDiameter,
              height: fillDiameter,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: _brandMark(fillDiameter * _glyphRatio * 1.1),
            ),
          ] else ...[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: backgroundColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: _brandMark(size * _glyphRatio),
            ),
          ]
        ],
      ),
    );
  }

  Widget _brandMark(double d) {
    switch (platform) {
      case SharePlatform.snapchat:
        return _disc(
          d,
          _snapchatYellow,
          SvgPicture.asset(
            'assets/logos/snapchat_ghost.svg',
            width: d * 0.66,
            height: d * 0.66,
          ),
        );
      case SharePlatform.x:
        return _disc(
          d,
          Colors.black,
          Image.asset(
            'assets/logos/x_glyph.png',
            width: d * 0.5,
            height: d * 0.5,
            fit: BoxFit.contain,
          ),
        );
      case SharePlatform.messenger:
        return SvgPicture.asset(
          'assets/logos/messenger.svg',
          width: d,
          height: d,
        );
      case SharePlatform.youtube:
        return Image.asset(
          'assets/logos/youtube.png',
          width: d,
          fit: BoxFit.contain,
        );
      case SharePlatform.instagram:
      case SharePlatform.facebook:
      case SharePlatform.whatsapp:
      case SharePlatform.tiktok:
      case SharePlatform.telegram:
      case SharePlatform.linkedin:
        return Image.asset(
          'assets/logos/${platform.name}.png',
          width: d,
          height: d,
          fit: BoxFit.contain,
        );
    }
  }

  Widget _disc(double d, Color color, Widget glyph) {
    return Container(
      width: d,
      height: d,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: glyph,
    );
  }
}
