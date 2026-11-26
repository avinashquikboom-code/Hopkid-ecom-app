import '../entities/category.dart';
import '../entities/coupon.dart';
import '../entities/order_entity.dart';
import '../entities/product.dart';
import '../entities/user_profile.dart';

abstract class ShopRepository {
  Future<List<Category>> getCategories();
  Future<List<Product>> getProducts({
    String? categoryId,
    String? subCategory,
    String? query,
    String? sortBy,
    int page = 1,
    int limit = 20,
  });
  Future<Product> getProductById(String id);
  Future<List<Coupon>> getCoupons();
  Future<List<OrderEntity>> getOrders({OrderStatus? filter});
  Future<OrderEntity> getOrderTracking(String orderId);
  Future<OrderEntity> placeOrder({
    required double totalAmount,
    required String address,
    required String paymentMethod,
    required String deliveryOption,
    required String primaryProductName,
    required String primaryProductImage,
    required int totalQuantity,
  });
  Future<UserProfile> getProfile();
}
