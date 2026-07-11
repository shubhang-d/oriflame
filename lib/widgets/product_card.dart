import 'package:flutter/material.dart';
import '../models/smart_post.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ProductCard extends StatelessWidget {
  final PostProduct product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.panelScrimLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.thumbnailAsset,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(product.name, style: AppTextStyles.h8Bold),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [_subtitle(), ..._badge()],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _subtitle() {
    final price = product.price;
    if (price != null) {
      return Text(price,
          style: AppTextStyles.captionBold
              .copyWith(fontSize: 14, fontWeight: FontWeight.w800));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.trending_up_rounded, size: 12, color: AppColors.white),
        const SizedBox(width: 4),
        Text(product.trendingLabel ?? '', style: AppTextStyles.caption),
      ],
    );
  }

  List<Widget> _badge() {
    final discount = product.discountLabel;
    if (discount == null) return const [];
    return [
      const SizedBox(width: 8),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: AppColors.discountBadge,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            discount,
            style: AppTextStyles.captionBold.copyWith(fontSize: 12),
          ),
        ),
      ),
    ];
  }
}
