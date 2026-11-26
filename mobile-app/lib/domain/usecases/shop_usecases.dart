import '../entities/category.dart';
import '../entities/coupon.dart';
import '../entities/order_entity.dart';
import '../entities/product.dart';
import '../repositories/shop_repository.dart';

class GetCategoriesUseCase {
  final ShopRepository _repository;
  const GetCategoriesUseCase(this._repository);
  Future<List<Category>> call() => _repository.getCategories();
}

class GetProductsUseCase {
  final ShopRepository _repository;
  const GetProductsUseCase(this._repository);

  Future<List<Product>> call({
    String? categoryId,
    String? subCategory,
    String? query,
    String? sortBy,
    int page = 1,
  }) {
    return _repository.getProducts(
      categoryId: categoryId,
      subCategory: subCategory,
      query: query,
      sortBy: sortBy,
      page: page,
    );
  }
}

class ValidateCouponUseCase {
  const ValidateCouponUseCase();

  double call({required Coupon coupon, required double subtotal}) {
    return coupon.calculateDiscount(subtotal);
  }
}

class PlaceOrderUseCase {
  final ShopRepository _repository;
  const PlaceOrderUseCase(this._repository);

  Future<OrderEntity> call({
    required double totalAmount,
    required String address,
    required String paymentMethod,
    required String deliveryOption,
    required String primaryProductName,
    required String primaryProductImage,
    required int totalQuantity,
  }) {
    return _repository.placeOrder(
      totalAmount: totalAmount,
      address: address,
      paymentMethod: paymentMethod,
      deliveryOption: deliveryOption,
      primaryProductName: primaryProductName,
      primaryProductImage: primaryProductImage,
      totalQuantity: totalQuantity,
    );
  }
}
