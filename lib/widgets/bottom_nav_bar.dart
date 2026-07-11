import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class OriflameBottomNav extends StatelessWidget {
  static const double contentHeight = 44;

  const OriflameBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: SizedBox(
        height: contentHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavIcon(svg: 'assets/icons/rocket.svg'),
            _NavIcon(svg: 'assets/icons/search.svg'),
            _NavIcon(
              svg: 'assets/icons/home_filled.svg',
            ),
            _NavIcon(svg: 'assets/icons/chat_bubble.svg'),
            _NavIcon(svg: 'assets/icons/account.svg'),
          ],
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final String? svg;
  final IconData? material;

  const _NavIcon({this.svg, this.material});

  @override
  Widget build(BuildContext context) {
    if (material != null) {
      return Icon(material, size: 27, color: AppColors.white);
    }
    return SvgPicture.asset(
      svg!,
      width: 25,
      height: 25,
      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
    );
  }
}
