import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/smart_post.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MusicRow extends StatelessWidget {
  final MusicSuggestion music;

  const MusicRow({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.panelScrim,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/music.svg',
            width: 12,
            height: 12,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'RECOMMENDED:  ',
                    style: AppTextStyles.overline,
                  ),
                  TextSpan(
                    text: music.title,
                    style: AppTextStyles.captionBold.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextSpan(
                    text: ' by ${music.artist}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
