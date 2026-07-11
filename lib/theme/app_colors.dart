import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Text/White
  static const Color white = Color(0xFFFFFFFF);

  /// Background/Light/700 — also Background/Light/500 and /300 resolve here.
  static const Color surface700 = Color(0xFF232425);

  /// Background/Light/900
  static const Color surface900 = Color(0xFF090B0E);

  /// Button/Light Mode/Primary
  static const Color primary = Color(0xFF111111);

  /// Button/Light Mode/Unselected
  static const Color unselected = Color(0xFF6B6B71);

  /// Text/500 — active nav icon, primary body text on light surfaces.
  static const Color text500 = Color(0xFF212328);

  /// Text/400
  static const Color text400 = Color(0xFF54565F);

  /// Text/300 — inactive nav icon, secondary labels.
  static const Color text300 = Color(0xFF656B76);

  /// Stroke/Light — hairline dividers, used at 8% alpha in the design.
  static const Color strokeLight = Color(0xFF7A7A7A);

  /// Base/Green — active "Smart Post" tab, active carousel dot, discount badge.
  static const Color green = Color(0xFF37C058);

  static const Color pillGreen = Color(0xFF73BF98);

  /// Status/Red/500
  static const Color red500 = Color(0xFFDD2828);

  /// Translucent panel behind the caption / product / music blocks.
  static final Color panelScrim = surface700.withValues(alpha: 0.3);

  /// Lighter scrim used behind the music suggestion row.
  static final Color panelScrimLight = Colors.white.withOpacity(0.3);

  /// Hairline under the header.
  static final Color hairline = strokeLight.withValues(alpha: 0.08);

  /// Active "Smart Post" tab (sampled #73BF98 — a muted brand green, distinct
  /// from the vivid Base/Green).
  static const Color tabGreen = Color(0xFF73BF98);

  /// The green "AI" chip on the assistant avatar (sampled #7EC086).
  static const Color aiBadge = Color(0xFF7EC086);

  /// Product discount pill ("30% off") — a teal-green, sampled ~#1B8E72.
  static const Color discountBadge = Color(0xFF00725B);

  /// Brand colours for the selected-target ring in the Quick Share row.
  static const Color brandInstagram = Color(0xFFE1306C);
  static const Color brandFacebook = Color(0xFF1877F2);

  static const List<Color> readyToShareGradient = [
    Color(0xFFFF6FD8),
    Color(0xFFB16CFF),
  ];
}
