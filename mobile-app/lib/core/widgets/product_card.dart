import 'package:material_ui/material_ui.dart';
import '../../domain/entities/product.dart';
import '../constants/app_colors.dart';
import 'badges_and_price.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isWishlisted;
  final VoidCallback onTap;
  final VoidCallback onToggleWishlist;

  const ProductCard({
    super.key,
    required this.product,
    required this.isWishlisted,
    required this.onTap,
    required this.onToggleWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPurple.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.lightPurple,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(17),
                        ),
                      ),
                      child: HopkidImage(
                        imageUrl: product.images.first,
                        fit: BoxFit.cover,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(17),
                        ),
                      ),
                    ),
                  ),
                  if (product.discountLabel != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: DiscountBadge(label: product.discountLabel!),
                    ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: const CircleBorder(),
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: onToggleWishlist,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            isWishlisted
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            size: 18,
                            color: isWishlisted
                                ? AppColors.error
                                : AppColors.secondaryText,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingWidget(rating: product.rating),
                  const SizedBox(height: 6),
                  PriceWidget(
                    price: product.price,
                    originalPrice: product.originalPrice,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
