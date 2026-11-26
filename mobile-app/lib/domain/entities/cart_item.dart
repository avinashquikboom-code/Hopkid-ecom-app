import 'product.dart';

class CartItem {
  final Product product;
  final String selectedSize;
  final int quantity;

  const CartItem({
    required this.product,
    required this.selectedSize,
    required this.quantity,
  });

  double get lineTotal => product.price * quantity;
  double get lineOriginalTotal => product.originalPrice * quantity;

  CartItem copyWith({
    Product? product,
    String? selectedSize,
    int? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
    );
  }
}
