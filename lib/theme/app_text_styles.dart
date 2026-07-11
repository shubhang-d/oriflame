import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String oriflame = 'Oriflame-Sans';
  static const String satoshi = 'Satoshi';
  static const String satoshi_bold = 'Satoshi-Bold';

  static TextStyle _osa({
    required double size,
    required double height,
    FontWeight weight = FontWeight.w400,
    FontStyle style = FontStyle.normal,
    Color color = AppColors.white,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: satoshi,
        fontSize: size,
        height: height,
        fontWeight: weight,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
      );

  static TextStyle _satoshi_bold({
    required double size,
    required double height,
    FontWeight weight = FontWeight.w400,
    FontStyle style = FontStyle.normal,
    Color color = AppColors.white,
    double? letterSpacing,
  }) =>
      TextStyle(
        fontFamily: satoshi_bold,
        fontSize: size,
        height: height,
        fontWeight: weight,
        fontStyle: style,
        letterSpacing: letterSpacing,
        color: color,
      );

  /// Caption body
  static TextStyle get caption =>
      _osa(size: 14, height: 1.45, weight: FontWeight.w400);

  /// Caption, bold
  static TextStyle get captionBold =>
      _satoshi_bold(size: 14, height: 1.3, weight: FontWeight.w600);

  /// Caption, italic — referral code / link lines.
  static TextStyle get captionItalic => _osa(
        size: 13,
        height: 1.5,
        style: FontStyle.italic,
        weight: FontWeight.w500,
        color: AppColors.white.withValues(alpha: 0.85),
      );

  static TextStyle get h8Bold =>
      _osa(size: 14, height: 1.35, weight: FontWeight.w800);

  /// H7 — 14px. Page tabs.
  static TextStyle get h7Bold => _osa(
        size: 14,
        height: 1.4,
        weight: FontWeight.w600,
        color: AppColors.text500,
      );

  /// The uppercase micro-labels: "CAPTION SUGGESTION", "RECOMMENDED:".
  static TextStyle get overline => _osa(
        size: 12,
        height: 1.2,
        weight: FontWeight.w500,
        letterSpacing: 0.2,
      );

  /// Satoshi — the "Your Assistant" / "Camera" labels under the header icons.
  static const TextStyle chromeLabel = TextStyle(
    fontFamily: satoshi,
    fontSize: 9,
    height: 1.2,
    fontWeight: FontWeight.w200,
    letterSpacing: 0.7,
    color: AppColors.text300,
  );
}
