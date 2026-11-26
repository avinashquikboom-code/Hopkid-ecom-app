import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/badges_and_price.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/selectors.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../../wishlist/viewmodels/wishlist_viewmodel.dart';
import '../viewmodels/product_details_viewmodel.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(productDetailsViewModelProvider.notifier)
          .loadProduct(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(productDetailsViewModelProvider);
    final vm = ref.read(productDetailsViewModelProvider.notifier);
    final product = details.product;

    if (product == null) {
      return const Scaffold(
        appBar: HopkidAppBar(title: 'Product Details'),
        body: LoadingWidget(),
      );
    }

    final isWishlisted = ref
        .watch(wishlistViewModelProvider)
        .any((p) => p.id == product.id);
    final isTablet = Responsive.isTablet(context);

    final gallerySection = Column(
      children: [
        AspectRatio(
          aspectRatio: 1.05,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: PageView.builder(
              itemCount: product.images.length,
              onPageChanged: vm.setImageIndex,
              itemBuilder: (context, idx) => HopkidImage(
                imageUrl: product.images[idx],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(product.images.length, (idx) {
            final active = idx == details.currentImageIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 7,
              width: active ? 22 : 7,
              decoration: BoxDecoration(
                color: active
                    ? AppColors.primaryPurple
                    : AppColors.primaryPurple.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(99),
              ),
            );
          }),
        ),
      ],
    );

    final infoSection = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (product.discountLabel != null) ...[
              DiscountBadge(label: product.discountLabel!),
              const SizedBox(width: 10),
            ],
            RatingWidget(
              rating: product.rating,
              reviewCount: product.reviewCount,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 10),
        PriceWidget(
          price: product.price,
          originalPrice: product.originalPrice,
          fontSize: 22,
        ),
        const SizedBox(height: 18),
        const Text(
          'Select Size',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 10),
        SizeSelector(
          sizes: product.sizes,
          selectedSize: details.selectedSize,
          onSelected: vm.selectSize,
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(width: 16),
            QuantitySelector(
              quantity: details.quantity,
              onDecrement: vm.decrementQuantity,
              onIncrement: vm.incrementQuantity,
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'Product Details',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 13.5,
            height: 1.5,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: 'Add to Cart',
                icon: AppIcons.cartLine,
                onPressed: () {
                  ref.read(cartViewModelProvider.notifier).addToCart(
                        product,
                        size: details.selectedSize,
                        quantity: details.quantity,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () => context.go('/cart'),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                label: 'Buy Now',
                onPressed: () {
                  ref.read(cartViewModelProvider.notifier).addToCart(
                        product,
                        size: details.selectedSize,
                        quantity: details.quantity,
                      );
                  context.push('/checkout');
                },
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: 'Product Details',
        actions: [
          IconButton(
            icon: Icon(
              isWishlisted ? AppIcons.heartFill : AppIcons.heartLine,
              color: isWishlisted ? AppColors.error : AppColors.primaryText,
            ),
            onPressed: () => ref
                .read(wishlistViewModelProvider.notifier)
                .toggleWishlist(product),
          ),
          IconButton(
            icon: const Icon(AppIcons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sharing ${product.name}')),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ResponsiveContainer(
            child: isTablet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: gallerySection),
                      const SizedBox(width: 28),
                      Expanded(flex: 6, child: infoSection),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gallerySection,
                      const SizedBox(height: 18),
                      infoSection,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
