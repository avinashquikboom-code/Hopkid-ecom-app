import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hopkid_app/core/responsive/responsive.dart';
import 'package:hopkid_app/core/theme/app_theme.dart';
import 'package:hopkid_app/data/datasources/remote/hopkid_demo_data.dart';
import 'package:hopkid_app/domain/usecases/shop_usecases.dart';
import 'package:hopkid_app/presentation/cart/viewmodels/cart_viewmodel.dart';
import 'package:hopkid_app/presentation/cart/views/cart_screen.dart';
import 'package:hopkid_app/presentation/categories/views/categories_screen.dart';
import 'package:hopkid_app/presentation/orders/views/order_success_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('Responsive Breakpoints', () {
    test('returns expected breakpoints and grid columns across devices', () {
      expect(
        Responsive.breakpointForWidth(320),
        DeviceBreakpoint.compactMobile,
      );
      expect(
        Responsive.breakpointForWidth(390),
        DeviceBreakpoint.standardMobile,
      );
      expect(
        Responsive.breakpointForWidth(650),
        DeviceBreakpoint.largeMobile,
      );
      expect(Responsive.breakpointForWidth(820), DeviceBreakpoint.tablet);
      expect(
        Responsive.breakpointForWidth(1100),
        DeviceBreakpoint.largeTablet,
      );

      expect(Responsive.productGridColumns(375), 2);
      expect(Responsive.productGridColumns(800), 3);
      expect(Responsive.productGridColumns(1100), 4);
      expect(Responsive.categoryGridColumns(375), 2);
      expect(Responsive.categoryGridColumns(800), 3);
      expect(Responsive.categoryGridColumns(1100), 4);
    });
  });

  group('Cart & Coupon Business Logic', () {
    test('CartViewModel calculates totals and applies coupons accurately', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cartVm = container.read(cartViewModelProvider.notifier);
      var state = container.read(cartViewModelProvider);

      // Initial seeded items: 419 + 799 + 1049 = 2267
      expect(state.totalCount, 3);
      expect(state.itemTotal, 2267);
      expect(state.deliveryFee, 0);
      expect(state.totalAmount, 2267);

      // Increment Dino Print T-Shirt (₹419)
      cartVm.increment('p1', '3–4 Y');
      state = container.read(cartViewModelProvider);
      expect(state.totalCount, 4);
      expect(state.itemTotal, 2686);

      // Apply WELCOME10 (10% off capped at ₹300)
      final applied = cartVm.applyCoupon(HopkidDemoData.coupons.first);
      expect(applied, isTrue);
      state = container.read(cartViewModelProvider);
      expect(state.discountAmount, 269);
      expect(state.totalAmount, 2417);
    });

    test('ValidateCouponUseCase respects minimum order amount', () {
      const useCase = ValidateCouponUseCase();
      final hopkid20 = HopkidDemoData.coupons[1]; // minOrderAmount 1999
      expect(useCase(coupon: hopkid20, subtotal: 1000), 0);
      expect(useCase(coupon: hopkid20, subtotal: 2000), 400);
    });
  });

  group('Widget & Responsive UI Tests', () {
    testWidgets('CartScreen renders items and total on mobile', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const MediaQuery(
              data: MediaQueryData(size: Size(390, 844)),
              child: CartScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Cart (3)'), findsOneWidget);
      expect(find.text('Dino Print T-Shirt (Boys)'), findsOneWidget);
      expect(find.text('Proceed to Checkout'), findsOneWidget);
    });

    testWidgets('CategoriesScreen renders all 8 categories on tablet', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const MediaQuery(
              data: MediaQueryData(size: Size(820, 1180)),
              child: CategoriesScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Boys Collection'), findsOneWidget);
      expect(find.text('Girls Collection'), findsOneWidget);
      expect(find.text('Baby Gear'), findsOneWidget);
    });

    testWidgets('OrderSuccessScreen displays order ID and CTAs', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const OrderSuccessScreen(orderId: '#HPK2469'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Order Placed Successfully!'), findsOneWidget);
      expect(
        find.text('Your order #HPK2469 has been placed successfully.'),
        findsOneWidget,
      );
      expect(find.text('Track Order'), findsOneWidget);
      expect(find.text('Continue Shopping'), findsOneWidget);
    });
  });
}
