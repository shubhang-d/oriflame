import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/smart_post.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CaptionPanel extends StatelessWidget {
  final SmartPost post;
  final String? overrideText;
  final bool expanded;
  final VoidCallback onToggleExpanded;
  final VoidCallback onOpenEditor;

  const CaptionPanel({
    super.key,
    required this.post,
    required this.expanded,
    required this.onToggleExpanded,
    required this.onOpenEditor,
    this.overrideText,
  });

  @override
  Widget build(BuildContext context) {
    String body;
    List<String> referralLines = [];

    if (overrideText != null) {
      final lines = overrideText!.split('\n');
      final captionLines = <String>[];
      final regex =
          RegExp(r'(?:https?:\/\/|www\.)|referral', caseSensitive: false);
      for (final line in lines) {
        if (regex.hasMatch(line)) {
          referralLines.add(line);
        } else {
          captionLines.add(line);
        }
      }
      body = captionLines.join('\n').trimRight();
    } else {
      body = '${post.caption}\n${post.hashtags}';
      if (post.referralCode.isNotEmpty) referralLines.add(post.referralCode);
      if (post.referralLink.isNotEmpty) referralLines.add(post.referralLink);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.panelScrim,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 3,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white, width: 0.8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      'AI',
                      style: AppTextStyles.captionBold.copyWith(
                        fontSize: 7,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text('CAPTION SUGGESTION', style: AppTextStyles.overline),
                ],
              ),
              GestureDetector(
                onTap: onOpenEditor,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/edit.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('Edit Caption', style: AppTextStyles.captionBold),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          _CaptionText(
            text: body,
            expanded: expanded,
            onToggle: onToggleExpanded,
          ),
          if (referralLines.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final line in referralLines)
              Text(line, style: AppTextStyles.captionItalic),
          ],
        ],
      ),
    );
  }
}

class _CaptionText extends StatefulWidget {
  final String text;
  final bool expanded;
  final VoidCallback onToggle;

  const _CaptionText({
    required this.text,
    required this.expanded,
    required this.onToggle,
  });

  @override
  State<_CaptionText> createState() => _CaptionTextState();
}

class _CaptionTextState extends State<_CaptionText> {
  static const int _collapsedLines = 2;
  static const String _ellipsis = '… ';

  late final TapGestureRecognizer _toggle;

  @override
  void initState() {
    super.initState();
    _toggle = TapGestureRecognizer()..onTap = () => widget.onToggle();
  }

  @override
  void dispose() {
    _toggle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = AppTextStyles.caption;
    final link = AppTextStyles.captionBold.copyWith(
      decoration: TextDecoration.underline,
      decorationColor: AppColors.white,
    );

    if (widget.expanded) {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(text: widget.text, style: base),
            const TextSpan(text: '  '),
            TextSpan(text: 'see less', style: link, recognizer: _toggle),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        final rootStyle = DefaultTextStyle.of(context).style;
        final textScaler = MediaQuery.textScalerOf(context);

        bool overflows(String body, {String? suffix}) {
          final painter = TextPainter(
            text: TextSpan(
              style: rootStyle,
              children: [
                TextSpan(text: body, style: base),
                if (suffix != null) TextSpan(text: suffix, style: link),
              ],
            ),
            maxLines: _collapsedLines,
            textScaler: textScaler,
            textDirection: Directionality.of(context),
          )..layout(maxWidth: maxWidth);
          final exceeded = painter.didExceedMaxLines;
          painter.dispose();
          return exceeded;
        }

        if (!overflows(widget.text)) {
          return Text(widget.text, style: base);
        }

        final graphemes = widget.text.characters;
        String prefix(int n) => graphemes.take(n).toString();

        var lo = 0;
        var hi = graphemes.length;
        while (lo < hi) {
          final mid = (lo + hi + 1) ~/ 2;
          if (overflows(prefix(mid) + _ellipsis, suffix: 'see more')) {
            hi = mid - 1;
          } else {
            lo = mid;
          }
        }

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: prefix(lo).trimRight() + _ellipsis, style: base),
              TextSpan(text: 'see more', style: link, recognizer: _toggle),
            ],
          ),
          maxLines: _collapsedLines,
        );
      },
    );
  }
}
