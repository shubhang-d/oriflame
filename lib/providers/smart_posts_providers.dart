import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/smart_post.dart';

final smartPostsProvider = Provider<List<SmartPost>>((ref) => kSmartPosts);

final currentPostIndexProvider = StateProvider<int>((ref) => 0);

final captionOverridesProvider =
    StateProvider<Map<String, String>>((ref) => {});

final expandedCaptionsProvider = StateProvider<Set<String>>((ref) => {});

final revealedProductsProvider =
    NotifierProvider<RevealedProducts, Set<String>>(RevealedProducts.new);

class RevealedProducts extends Notifier<Set<String>> {
  @override
  Set<String> build() => {};

  bool isRevealed(String postId) => state.contains(postId);

  void reveal(String postId) {
    if (state.contains(postId)) return;
    state = {...state, postId};
  }
}
