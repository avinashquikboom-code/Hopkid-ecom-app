import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/product.dart';

class ProductDetailsState {
  final Product? product;
  final String selectedSize;
  final int quantity;
  final int currentImageIndex;

  const ProductDetailsState({
    this.product,
    this.selectedSize = '3–4 Y',
    this.quantity = 1,
    this.currentImageIndex = 0,
  });

  ProductDetailsState copyWith({
    Product? product,
    String? selectedSize,
    int? quantity,
    int? currentImageIndex,
  }) {
    return ProductDetailsState(
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }
}

class ProductDetailsViewModel extends Notifier<ProductDetailsState> {
  @override
  ProductDetailsState build() => const ProductDetailsState();

  Future<void> loadProduct(String productId) async {
    final product = await ref.read(shopRepositoryProvider).getProductById(productId);
    state = ProductDetailsState(
      product: product,
      selectedSize: product.sizes.contains('3–4 Y')
          ? '3–4 Y'
          : product.sizes.first,
      quantity: 1,
      currentImageIndex: 0,
    );
  }

  void selectSize(String size) {
    state = state.copyWith(selectedSize: size);
  }

  void incrementQuantity() {
    final maxStock = state.product?.stockCount ?? 10;
    if (state.quantity < maxStock) {
      state = state.copyWith(quantity: state.quantity + 1);
    }
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      state = state.copyWith(quantity: state.quantity - 1);
    }
  }

  void setImageIndex(int index) {
    state = state.copyWith(currentImageIndex: index);
  }
}

final productDetailsViewModelProvider =
    NotifierProvider<ProductDetailsViewModel, ProductDetailsState>(
  ProductDetailsViewModel.new,
);
