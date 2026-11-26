import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/cart/viewmodels/cart_viewmodel.dart';
import '../constants/app_colors.dart';

class BottomNavigationWidget extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationWidget({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartViewModelProvider).totalCount;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            height: 66,
            backgroundColor: AppColors.surface,
            indicatorColor: AppColors.lightPurple,
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined, color: AppColors.secondaryText),
                selectedIcon: Icon(Icons.home_rounded, color: AppColors.primaryPurple),
                label: 'Home',
              ),
              const NavigationDestination(
                icon: Icon(Icons.grid_view_outlined, color: AppColors.secondaryText),
                selectedIcon:
                    Icon(Icons.grid_view_rounded, color: AppColors.primaryPurple),
                label: 'Category',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  backgroundColor: AppColors.primaryPurple,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.secondaryText,
                  ),
                ),
                selectedIcon: Badge(
                  isLabelVisible: cartCount > 0,
                  label: Text('$cartCount'),
                  backgroundColor: AppColors.primaryPurple,
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: AppColors.primaryPurple,
                  ),
                ),
                label: 'Cart',
              ),
              const NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined, color: AppColors.secondaryText),
                selectedIcon:
                    Icon(Icons.receipt_long_rounded, color: AppColors.primaryPurple),
                label: 'Orders',
              ),
              const NavigationDestination(
                icon: Icon(Icons.person_outline_rounded, color: AppColors.secondaryText),
                selectedIcon:
                    Icon(Icons.person_rounded, color: AppColors.primaryPurple),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
