import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/badges_and_price.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../viewmodels/wishlist_viewmodel.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);
    final vm = ref.read(wishlistViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const HopkidAppBar(title: 'My Wishlist'),
      body: SafeArea(
        child: wishlist.isEmpty
            ? EmptyStateWidget(
                icon: Icons.favorite_border_rounded,
                title: 'Your wishlist is empty',
                subtitle: 'Save your favorite kids outfits to revisit anytime.',
                actionLabel: 'Browse Products',
                onAction: () => context.go('/home'),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ResponsiveContainer(
                  child: ResponsiveGrid(
                    itemCount: wishlist.length,
                    childAspectRatio: 0.65,
                    itemBuilder: (context, idx) {
                      final product = wishlist[idx];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: InkWell(
                                      onTap: () =>
                                          context.push('/product/${product.id}'),
                                      child: HopkidImage(
                                        imageUrl: product.images.first,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                          top: Radius.circular(17),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: Material(
                                      color: Colors.white,
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap: () => vm.remove(product.id),
                                        child: const Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Icon(
                                            Icons.favorite_rounded,
                                            size: 18,
                                            color: AppColors.error,
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
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  PriceWidget(
                                    price: product.price,
                                    originalPrice: product.originalPrice,
                                    fontSize: 14,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 36,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(cartViewModelProvider.notifier)
                                            .addToCart(product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${product.name} added to cart!',
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(0, 36),
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: const Text(
                                        'Add to Cart',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
