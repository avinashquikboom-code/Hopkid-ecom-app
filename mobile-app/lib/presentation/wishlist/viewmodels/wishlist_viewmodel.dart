import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/remote/hopkid_demo_data.dart';
import '../../../domain/entities/product.dart';

class WishlistViewModel extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    // Seed with 2 popular items so Wishlist feels alive on first visit
    return [HopkidDemoData.products[0], HopkidDemoData.products[2]];
  }

  bool isWishlisted(String productId) =>
      state.any((product) => product.id == productId);

  void toggleWishlist(Product product) {
    if (isWishlisted(product.id)) {
      state = state.where((p) => p.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  void remove(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}

final wishlistViewModelProvider =
    NotifierProvider<WishlistViewModel, List<Product>>(
  WishlistViewModel.new,
);
