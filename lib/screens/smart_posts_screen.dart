import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/smart_posts_providers.dart';
import '../theme/app_colors.dart';
import '../widgets/oriflame_header.dart';
import '../widgets/smart_post_view.dart';

class SmartPostsScreen extends ConsumerWidget {
  const SmartPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(smartPostsProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const OriflameHeader(),
          Expanded(
            child: ColoredBox(
              color: AppColors.surface900,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: posts.length,
                onPageChanged: (index) =>
                    ref.read(currentPostIndexProvider.notifier).state = index,
                itemBuilder: (context, index) => SmartPostView(
                  post: posts[index],
                  index: index,
                  total: posts.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
