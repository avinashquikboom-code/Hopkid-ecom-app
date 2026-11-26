import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/auth/views/auth_screen.dart';
import '../../presentation/cart/views/cart_screen.dart';
import '../../presentation/categories/views/categories_screen.dart';
import '../../presentation/checkout/views/checkout_screen.dart';
import '../../presentation/home/views/home_screen.dart';
import '../../presentation/offers/views/offers_screen.dart';
import '../../presentation/onboarding/views/onboarding_screen.dart';
import '../../presentation/orders/views/my_orders_screen.dart';
import '../../presentation/orders/views/order_success_screen.dart';
import '../../presentation/products/views/product_details_screen.dart';
import '../../presentation/products/views/product_listing_screen.dart';
import '../../presentation/profile/views/profile_screen.dart';
import '../../presentation/splash/views/splash_screen.dart';
import '../../presentation/tracking/views/order_tracking_screen.dart';
import '../../presentation/wishlist/views/wishlist_screen.dart';
import '../widgets/bottom_navigation_widget.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, _) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (_, _) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (_, _) => const AuthScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BottomNavigationWidget(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, _) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (_, _) => const CategoriesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/cart',
              builder: (_, _) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/orders',
              builder: (_, _) => const MyOrdersScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (_, _) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) {
        final category = state.uri.queryParameters['category'] ?? 'boys';
        return ProductListingScreen(categoryId: category);
      },
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'p1';
        return ProductDetailsScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/checkout',
      builder: (_, _) => const CheckoutScreen(),
    ),
    GoRoute(
      path: '/order-success/:orderId',
      builder: (context, state) {
        final orderId = Uri.decodeComponent(
          state.pathParameters['orderId'] ?? '#HPK2469',
        );
        return OrderSuccessScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/tracking/:orderId',
      builder: (context, state) {
        final orderId = Uri.decodeComponent(
          state.pathParameters['orderId'] ?? '#HPK2469',
        );
        return OrderTrackingScreen(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/wishlist',
      builder: (_, _) => const WishlistScreen(),
    ),
    GoRoute(
      path: '/offers',
      builder: (_, _) => const OffersScreen(),
    ),
  ],
);
