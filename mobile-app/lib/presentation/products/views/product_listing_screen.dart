import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/search_bar_widget.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../wishlist/viewmodels/wishlist_viewmodel.dart';
import '../viewmodels/product_listing_viewmodel.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
  final String categoryId;

  const ProductListingScreen({super.key, this.categoryId = 'boys'});

  @override
  ConsumerState<ProductListingScreen> createState() =>
      _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  static const List<String> _chips = [
    'All',
    'T-Shirts',
    'Shirts',
    'Jeans',
    'Jackets',
  ];

  bool _showSearch = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productListingViewModelProvider.notifier).setCategory(
            widget.categoryId,
          );
    });
  }

  String get _titleForCategory {
    switch (widget.categoryId) {
      case 'girls':
        return 'Girls Collection';
      case 'baby':
        return 'Baby & Newborn';
      case 'toys':
        return 'Toys & Games';
      default:
        return 'Boys Collection';
    }
  }

  void _showSortSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sort Products',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Popularity'),
              onTap: () {
                ref
                    .read(productListingViewModelProvider.notifier)
                    .setSortBy('popular');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('Price: Low to High'),
              onTap: () {
                ref
                    .read(productListingViewModelProvider.notifier)
                    .setSortBy('price_asc');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('Price: High to Low'),
              onTap: () {
                ref
                    .read(productListingViewModelProvider.notifier)
                    .setSortBy('price_desc');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              title: const Text('Highest Rated'),
              onTap: () {
                ref
                    .read(productListingViewModelProvider.notifier)
                    .setSortBy('rating');
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(productListingViewModelProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: _titleForCategory,
        actions: [
          IconButton(
            icon: Icon(_showSearch ? AppIcons.close : AppIcons.search),
            onPressed: () => setState(() => _showSearch = !_showSearch),
          ),
          IconButton(
            icon: const Icon(AppIcons.filter),
            onPressed: _showSortSheet,
          ),
        ],
      ),
      body: SafeArea(
        child: listingAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: () => ref
                .read(productListingViewModelProvider.notifier)
                .setCategory(widget.categoryId),
          ),
          data: (state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: ResponsiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_showSearch) ...[
                      SearchBarWidget(
                        hintText: 'Search in $_titleForCategory...',
                        onChanged: (q) => ref
                            .read(productListingViewModelProvider.notifier)
                            .search(q),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // Filter Chips
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _chips.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, idx) {
                          final chip = _chips[idx];
                          final selected = state.selectedSubCategory == chip;
                          return ChoiceChip(
                            label: Text(chip),
                            selected: selected,
                            onSelected: (_) => ref
                                .read(productListingViewModelProvider.notifier)
                                .selectSubCategory(chip),
                            selectedColor: AppColors.primaryPurple,
                            backgroundColor: AppColors.surface,
                            side: BorderSide(
                              color: selected
                                  ? AppColors.primaryPurple
                                  : AppColors.border,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color:
                                  selected ? Colors.white : AppColors.primaryText,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (state.products.isEmpty)
                      EmptyStateWidget(
                        icon: AppIcons.tshirt,
                        title: 'No products found',
                        subtitle:
                            'Try another filter or explore all kids fashion.',
                        actionLabel: 'Show All',
                        onAction: () => ref
                            .read(productListingViewModelProvider.notifier)
                            .selectSubCategory('All'),
                      )
                    else
                      ResponsiveGrid(
                        itemCount: state.products.length,
                        itemBuilder: (context, idx) {
                          final product = state.products[idx];
                          final isFav = wishlist.any((p) => p.id == product.id);
                          return ProductCard(
                            product: product,
                            isWishlisted: isFav,
                            onTap: () => context.push('/product/${product.id}'),
                            onToggleWishlist: () => ref
                                .read(wishlistViewModelProvider.notifier)
                                .toggleWishlist(product),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
