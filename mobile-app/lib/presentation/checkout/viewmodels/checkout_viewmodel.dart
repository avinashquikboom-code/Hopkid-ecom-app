import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/order_entity.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../../orders/viewmodels/orders_viewmodel.dart';

enum DeliveryOption { standard, express }

enum PaymentMethod { upi, card, netBanking, cod }

class CheckoutState {
  final String addressTitle;
  final String addressLine;
  final DeliveryOption deliveryOption;
  final PaymentMethod paymentMethod;
  final bool isPlacingOrder;
  final String? errorMessage;

  const CheckoutState({
    this.addressTitle = 'Home',
    this.addressLine = 'Flat 402, Blossom Heights, Baner Road, Pune - 411045',
    this.deliveryOption = DeliveryOption.standard,
    this.paymentMethod = PaymentMethod.upi,
    this.isPlacingOrder = false,
    this.errorMessage,
  });

  double get extraDeliveryFee =>
      deliveryOption == DeliveryOption.express ? 49 : 0;

  CheckoutState copyWith({
    String? addressTitle,
    String? addressLine,
    DeliveryOption? deliveryOption,
    PaymentMethod? paymentMethod,
    bool? isPlacingOrder,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CheckoutState(
      addressTitle: addressTitle ?? this.addressTitle,
      addressLine: addressLine ?? this.addressLine,
      deliveryOption: deliveryOption ?? this.deliveryOption,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CheckoutViewModel extends Notifier<CheckoutState> {
  @override
  CheckoutState build() => const CheckoutState();

  void updateAddress(String title, String line) {
    state = state.copyWith(addressTitle: title, addressLine: line);
  }

  void selectDelivery(DeliveryOption option) {
    state = state.copyWith(deliveryOption: option);
  }

  void selectPayment(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  Future<OrderEntity?> placeOrder() async {
    final cart = ref.read(cartViewModelProvider);
    if (cart.items.isEmpty) {
      state = state.copyWith(errorMessage: 'Your cart is empty.');
      return null;
    }
    if (state.addressLine.trim().isEmpty) {
      state = state.copyWith(errorMessage: 'Please provide a delivery address.');
      return null;
    }

    state = state.copyWith(isPlacingOrder: true, clearError: true);
    try {
      final total = cart.itemTotal - cart.discountAmount + state.extraDeliveryFee;
      final order = await ref.read(placeOrderUseCaseProvider).call(
            totalAmount: total,
            address: '${state.addressTitle}: ${state.addressLine}',
            paymentMethod: state.paymentMethod.name,
            deliveryOption: state.deliveryOption.name,
            primaryProductName: cart.items.first.product.name,
            primaryProductImage: cart.items.first.product.images.first,
            totalQuantity: cart.totalCount,
          );
      ref.read(cartViewModelProvider.notifier).clearCart();
      await ref.read(ordersViewModelProvider.notifier).refresh();
      state = state.copyWith(isPlacingOrder: false);
      return order;
    } catch (e) {
      state = state.copyWith(
        isPlacingOrder: false,
        errorMessage: 'Unable to place order. Please try again.',
      );
      return null;
    }
  }
}

final checkoutViewModelProvider =
    NotifierProvider<CheckoutViewModel, CheckoutState>(
  CheckoutViewModel.new,
);
