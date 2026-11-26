import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/category_card.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../viewmodels/categories_viewmodel.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesViewModelProvider);
    final cartCount = ref.watch(cartViewModelProvider).totalCount;

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: 'Categories',
        showBack: Navigator.of(context).canPop(),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () => context.go('/cart'),
                icon: const Icon(AppIcons.cartLine),
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
      body: SafeArea(
        child: categoriesAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: () =>
                ref.read(categoriesViewModelProvider.notifier).refresh(),
          ),
          data: (categories) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ResponsiveContainer(
                child: ResponsiveGrid(
                  itemCount: categories.length,
                  columnsForWidth: Responsive.categoryGridColumns,
                  childAspectRatio: 1.05,
                  itemBuilder: (context, idx) {
                    final category = categories[idx];
                    return CategoryCard(
                      category: category,
                      onTap: () => context.push('/products?category=${category.id}'),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
