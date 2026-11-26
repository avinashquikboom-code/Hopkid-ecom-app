import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/search_bar_widget.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../../wishlist/viewmodels/wishlist_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final PageController _bannerController = PageController();
  int _bannerIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeAsync = ref.watch(homeViewModelProvider);
    final cartCount = ref.watch(cartViewModelProvider).totalCount;
    final wishlist = ref.watch(wishlistViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryPurple,
          onRefresh: () => ref.read(homeViewModelProvider.notifier).refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24),
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.lightPurple,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          AppIcons.crownFill,
                          color: AppColors.primaryPurple,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        AppConstants.appName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () => context.push('/offers'),
                        icon: const Icon(AppIcons.notification),
                        color: AppColors.primaryText,
                      ),
                      Stack(
                        children: [
                          IconButton(
                            onPressed: () => context.go('/cart'),
                            icon: const Icon(AppIcons.cartLine),
                            color: AppColors.primaryText,
                          ),
                          if (cartCount > 0)
                            Positioned(
                              right: 6,
                              top: 6,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$cartCount',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Search Bar
                  SearchBarWidget(
                    controller: _searchController,
                    onChanged: (q) =>
                        ref.read(homeViewModelProvider.notifier).search(q),
                  ),
                  const SizedBox(height: 18),

                  // Promotional Banner Slider
                  SizedBox(
                    height: Responsive.isTablet(context) ? 210 : 172,
                    child: PageView.builder(
                      controller: _bannerController,
                      itemCount: 3,
                      onPageChanged: (idx) => setState(() => _bannerIndex = idx),
                      itemBuilder: (context, idx) {
                        return Container(
                          margin: const EdgeInsets.only(right: 4),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.lightPurple, AppColors.pink],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                      child: const Text(
                                        'Up to 40% OFF',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.primaryPurple,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'New Kids Collection',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () =>
                                          context.push('/products?category=boys'),
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(116, 36),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                      ),
                                      child: const Text(
                                        'Shop Now',
                                        style: TextStyle(fontSize: 12.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    idx == 1
                                        ? 'assets/images/banners/offers_banner.jpg'
                                        : 'assets/images/banners/home_banner_kids.jpg',
                                    fit: BoxFit.cover,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      final active = i == _bannerIndex;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        height: 6,
                        width: active ? 18 : 6,
                        decoration: BoxDecoration(
                          color: active
                              ? AppColors.primaryPurple
                              : AppColors.primaryPurple.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Body from HomeViewModel
                  homeAsync.when(
                    loading: () => const LoadingWidget(),
                    error: (err, _) => HopkidErrorWidget(
                      message: err.toString(),
                      onRetry: () =>
                          ref.read(homeViewModelProvider.notifier).refresh(),
                    ),
                    data: (homeData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Shortcuts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Shop by Category',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              TextButton(
                                onPressed: () => context.go('/categories'),
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: homeData.shortcuts.map((cat) {
                              final shortName = cat.name.split(' ').first;
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: InkWell(
                                    onTap: () => context.push(
                                      '/products?category=${cat.id}',
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(cat.bgColorHex),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            AppIcons.forCategory(cat.id),
                                            color: AppColors.primaryPurple,
                                            size: 24,
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            shortName,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),

                          // Services Section
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: const [
                                _ServicePill(
                                  icon: AppIcons.shipping,
                                  label: 'Free\nShipping',
                                ),
                                _ServicePill(
                                  icon: AppIcons.returns,
                                  label: 'Easy\nReturns',
                                ),
                                _ServicePill(
                                  icon: AppIcons.shield,
                                  label: 'Secure\nPayment',
                                ),
                                _ServicePill(
                                  icon: AppIcons.award,
                                  label: 'Genuine\nProducts',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),

                          // Trending Now
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Trending Now',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    context.push('/products?category=boys'),
                                child: const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          if (homeData.trendingProducts.isEmpty)
                            const EmptyStateWidget(
                              icon: AppIcons.search,
                              title: 'No matching products',
                              subtitle: 'Try searching for Dino, Hoodie, or Dress.',
                            )
                          else
                            SizedBox(
                              height: 248,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: homeData.trendingProducts.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, idx) {
                                  final product = homeData.trendingProducts[idx];
                                  final isFav = wishlist.any(
                                    (p) => p.id == product.id,
                                  );
                                  return SizedBox(
                                    width: 168,
                                    child: ProductCard(
                                      product: product,
                                      isWishlisted: isFav,
                                      onTap: () =>
                                          context.push('/product/${product.id}'),
                                      onToggleWishlist: () => ref
                                          .read(wishlistViewModelProvider.notifier)
                                          .toggleWishlist(product),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ServicePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ServicePill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.lightPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: AppColors.primaryPurple),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryText,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
