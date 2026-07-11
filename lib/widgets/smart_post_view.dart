import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/share_platform.dart';
import '../models/smart_post.dart';
import '../providers/smart_posts_providers.dart';
import '../screens/edit_caption_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'bottom_nav_bar.dart';
import 'caption_panel.dart';
import 'hero_overlay.dart';
import 'music_row.dart';
import 'product_card.dart';
import 'quick_share_row.dart';
import 'share_progress_dialog.dart';

class SmartPostView extends ConsumerStatefulWidget {
  final SmartPost post;
  final int index;
  final int total;

  const SmartPostView({
    super.key,
    required this.post,
    required this.index,
    required this.total,
  });

  @override
  ConsumerState<SmartPostView> createState() => _SmartPostViewState();
}

class _SmartPostViewState extends ConsumerState<SmartPostView> {
  static const Duration _revealDelay = Duration(seconds: 3);

  Timer? _revealTimer;

  @override
  void initState() {
    super.initState();
    if (ref.read(currentPostIndexProvider) == widget.index) {
      _maybeScheduleReveal();
    }
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    super.dispose();
  }

  void _maybeScheduleReveal() {
    if (_revealTimer != null) return;
    if (widget.post.product == null) return;
    if (ref.read(revealedProductsProvider).contains(widget.post.id)) return;
    _revealTimer = Timer(_revealDelay, () {
      if (!mounted) return;
      ref.read(revealedProductsProvider.notifier).reveal(widget.post.id);
    });
  }

  void _onShare(SharePlatform platform) {
    if (platform == SharePlatform.instagram) {
      ShareProgressDialog.show(context);
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 80),
            backgroundColor: AppColors.surface900,
            content: Text(
              'Sharing "${widget.post.product?.name}" to ${platform.label}…',
              style: AppTextStyles.caption,
            ),
          ),
        );
    }
  }

  static String _composeCaption(SmartPost p) =>
      '${p.caption} ${p.hashtags}\n${p.referralLink}\n${p.referralCode}';

  Future<void> _openEditor() async {
    final post = widget.post;
    final overrides = ref.read(captionOverridesProvider);
    final initial = overrides[post.id] ?? _composeCaption(post);

    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => EditCaptionScreen(initialText: initial),
      ),
    );
    if (result == null) return;

    ref.read(captionOverridesProvider.notifier).state = {
      ...ref.read(captionOverridesProvider),
      post.id: result,
    };
  }

  void _toggleCaption(String postId) {
    final current = ref.read(expandedCaptionsProvider);
    ref.read(expandedCaptionsProvider.notifier).state = current.contains(postId)
        ? ({...current}..remove(postId))
        : {...current, postId};
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(currentPostIndexProvider, (previous, next) {
      if (next == widget.index) {
        _maybeScheduleReveal();
      } else {
        _revealTimer?.cancel();
        _revealTimer = null;
      }
    });

    final post = widget.post;
    final revealed = ref.watch(revealedProductsProvider).contains(post.id);
    final captionOverride = ref.watch(captionOverridesProvider)[post.id];
    final expanded = ref.watch(expandedCaptionsProvider).contains(post.id);
    // Keep the content stack clear of the nav icons floating over the hero.
    final navClearance = MediaQuery.of(context).padding.bottom +
        OriflameBottomNav.contentHeight +
        14;

    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            post.heroAsset,
            fit: BoxFit.cover,
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xB32F2F2F), Colors.transparent],
                stops: [0.0, 0.18],
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xB32F2F2F)],
                stops: [0.42, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            top: 12,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: HeroHeadline(
                    avatarAsset: post.creatorAvatarAsset,
                    badgeLabel: post.badgeLabel,
                    communityLine: post.communityLine,
                  ),
                ),
                const SizedBox(width: 8),
                PostCounterPill(index: widget.index, total: widget.total),
              ],
            ),
          ),
          Positioned(
            right: 14,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: const Alignment(0, -0.32),
              child: PageDots(index: widget.index, total: widget.total),
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: navClearance,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.product != null)
                  _ProductReveal(
                    revealed: revealed,
                    child: ProductCard(
                      product: post.product!,
                      onTap: () {
                        final url = post.id == 'eclat-amour'
                            ? 'https://in.oriflame.com/products/product?code=35649&query=eclat%2520amour'
                            : 'https://in.oriflame.com/products/product?code=42655&query=lipstick';
                        launchUrl(
                          Uri.parse(url),
                          mode: LaunchMode.externalApplication,
                        );
                      },
                    ),
                  ),
                MusicRow(music: post.music),
                const SizedBox(height: 10),
                CaptionPanel(
                  post: post,
                  overrideText: captionOverride,
                  expanded: expanded,
                  onToggleExpanded: () => _toggleCaption(post.id),
                  onOpenEditor: _openEditor,
                ),
                const SizedBox(height: 16),
                QuickShareRow(onShare: _onShare),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: OriflameBottomNav(),
          ),
        ],
      ),
    );
  }
}

class _ProductReveal extends StatelessWidget {
  final bool revealed;
  final Widget child;

  const _ProductReveal({required this.revealed, required this.child});

  @override
  Widget build(BuildContext context) {
    if (!revealed) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
        child: child,
        builder: (context, t, child) => Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - t)),
            child: child,
          ),
        ),
      ),
    );
  }
}
