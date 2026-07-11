class PostProduct {
  final String name;
  final String thumbnailAsset;
  final String? price;
  final String? trendingLabel;
  final String? discountLabel;

  const PostProduct({
    required this.name,
    required this.thumbnailAsset,
    this.price,
    this.trendingLabel,
    this.discountLabel,
  });
}

class MusicSuggestion {
  final String title;
  final String artist;

  const MusicSuggestion({required this.title, required this.artist});
}

/// One card in the reels-style vertical pager.
class SmartPost {
  final String id;
  final String heroAsset;
  final String creatorAvatarAsset;
  final String badgeLabel;
  final String communityLine;

  final PostProduct? product;
  final MusicSuggestion music;
  final String caption;
  final String hashtags;

  final String referralCode;
  final String referralLink;

  const SmartPost({
    required this.id,
    required this.heroAsset,
    required this.creatorAvatarAsset,
    required this.badgeLabel,
    required this.communityLine,
    this.product,
    required this.music,
    required this.caption,
    required this.hashtags,
    required this.referralCode,
    required this.referralLink,
  });
}

const String _kCreatorAvatar = 'assets/images/creator_avatar.png';
const String _kReferralCode = 'Use my referral code: UK-AMANDA3012';
const String _kReferralLink =
    'Use my referral link: www.oriflame.com/giordani/amada3012';

const List<SmartPost> kSmartPosts = [
  SmartPost(
    id: 'giordani-gold-lipstick',
    heroAsset: 'assets/images/hero_lipstick.jpg',
    creatorAvatarAsset: _kCreatorAvatar,
    badgeLabel: 'Ready to share',
    communityLine: 'High-converting in Oriflame Community',
    product: PostProduct(
      name: 'Girodani Gold Lipstick',
      thumbnailAsset: 'assets/images/product_lipstick.png',
      price: r'$14.99',
      discountLabel: '30% off',
    ),
    music: MusicSuggestion(title: 'Bad Habits', artist: 'Ed Sheeran'),
    caption:
        "💄Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick "
        "SPF 25! This luxurious creamy lipstick doesn't just promise rich "
        "pigments but brings you the benefits of hyaluronic acid and "
        "collagen-boosting peptides too. Pamper your lips with care while "
        "enjoying a long-lasting, luminous matte colour.",
    hashtags: '🎀✨ #Oriflame #GiordaniGold #LipCareGoals',
    referralCode: _kReferralCode,
    referralLink: _kReferralLink,
  ),
  SmartPost(
    id: 'eclat-amour',
    heroAsset: 'assets/images/hero_perfume.png',
    creatorAvatarAsset: _kCreatorAvatar,
    badgeLabel: 'Ready to share',
    communityLine: 'High-converting in Oriflame Community',
    product: PostProduct(
      name: 'Eclat Amour',
      thumbnailAsset: 'assets/images/product_perfume.webp',
      trendingLabel: 'Trending right now and on sale',
      discountLabel: '30% off',
    ),
    music: MusicSuggestion(title: 'Unstoppable', artist: 'Sia'),
    caption:
        '✨ Experience the elegance of Eclat Amour—a fragrance that captures '
        'the essence of romance and sophistication. Let every spritz wrap you '
        'in timeless charm and effortless allure. 💕',
    hashtags: '#EclatAmour #TimelessElegance',
    referralCode: _kReferralCode,
    referralLink: _kReferralLink,
  ),
  SmartPost(
    id: 'eclat-amour-body-mist',
    heroAsset: 'assets/images/hero_lash.png',
    creatorAvatarAsset: _kCreatorAvatar,
    badgeLabel: 'Ready to share',
    communityLine: 'High-converting in Oriflame Community',
    music: MusicSuggestion(title: 'Vogue', artist: 'Madonna'),
    caption:
        '💄Elevate your beauty with the Giordani Gold - Eternal Glow Lipstick SPF 25!'
        'This luxurious creamy lipstick doesnt just promise'
        'rich pigments but brings you the benefits of hyaluronic acid and'
        'collagen-boosting peptides too. Pamper your lips with'
        'care while enjoying a long-lasting, luminous matte'
        'colour. 💋 ✨ ',
    hashtags: '#Oriflame #GiordaniGold #LipCareGoals',
    referralCode: _kReferralCode,
    referralLink: _kReferralLink,
  ),
];
