import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../data/datasources/remote/hopkid_demo_data.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/coupon.dart';
import '../../../domain/entities/product.dart';

class CartState {
  final List<CartItem> items;
  final Coupon? appliedCoupon;
  final bool isLoading;

  const CartState({
    this.items = const [],
    this.appliedCoupon,
    this.isLoading = false,
  });

  int get totalCount => items.fold(0, (sum, i) => sum + i.quantity);

  double get itemTotal => items.fold(0, (sum, i) => sum + i.lineTotal);

  double get discountAmount {
    if (appliedCoupon == null) return 0;
    return appliedCoupon!.calculateDiscount(itemTotal);
  }

  double get deliveryFee => itemTotal >= 999 || items.isEmpty ? 0 : 49;

  double get totalAmount =>
      (itemTotal - discountAmount + deliveryFee).clamp(0, double.infinity);

  CartState copyWith({
    List<CartItem>? items,
    Coupon? appliedCoupon,
    bool clearCoupon = false,
    bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class CartViewModel extends Notifier<CartState> {
  @override
  CartState build() {
    // Pre-populate with the 3 sample products from the specification
    final products = HopkidDemoData.products;
    return CartState(
      items: [
        CartItem(product: products[0], selectedSize: '3–4 Y', quantity: 1),
        CartItem(product: products[1], selectedSize: '5–6 Y', quantity: 1),
        CartItem(product: products[3], selectedSize: '3–4 Y', quantity: 1),
      ],
    );
  }

  void addToCart(Product product, {String size = '3–4 Y', int quantity = 1}) {
    final index = state.items.indexWhere(
      (i) => i.product.id == product.id && i.selectedSize == size,
    );
    final updated = List<CartItem>.from(state.items);
    if (index >= 0) {
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + quantity,
      );
    } else {
      updated.add(
        CartItem(product: product, selectedSize: size, quantity: quantity),
      );
    }
    state = state.copyWith(items: updated);
    _persist();
  }

  void increment(String productId, String size) {
    final updated = state.items.map((item) {
      if (item.product.id == productId && item.selectedSize == size) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    state = state.copyWith(items: updated);
    _persist();
  }

  void decrement(String productId, String size) {
    final updated = <CartItem>[];
    for (final item in state.items) {
      if (item.product.id == productId && item.selectedSize == size) {
        if (item.quantity > 1) {
          updated.add(item.copyWith(quantity: item.quantity - 1));
        }
      } else {
        updated.add(item);
      }
    }
    state = state.copyWith(items: updated);
    _persist();
  }

  void removeItem(String productId, String size) {
    final updated = state.items
        .where(
          (i) => !(i.product.id == productId && i.selectedSize == size),
        )
        .toList();
    state = state.copyWith(items: updated);
    _persist();
  }

  bool applyCoupon(Coupon coupon) {
    final discount = ref
        .read(validateCouponUseCaseProvider)
        .call(coupon: coupon, subtotal: state.itemTotal);
    if (discount <= 0) return false;
    state = state.copyWith(appliedCoupon: coupon);
    return true;
  }

  void removeCoupon() {
    state = state.copyWith(clearCoupon: true);
  }

  void clearCart() {
    state = const CartState();
    _persist();
  }

  void _persist() {
    final entries = state.items
        .map(
          (i) => {
            'productId': i.product.id,
            'size': i.selectedSize,
            'qty': i.quantity,
          },
        )
        .toList();
    ref.read(localStorageProvider).saveCartEntries(entries);
  }
}

final cartViewModelProvider = NotifierProvider<CartViewModel, CartState>(
  CartViewModel.new,
);
