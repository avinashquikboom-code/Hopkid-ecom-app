import '../../../core/network/api_client.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/coupon.dart';
import '../../../domain/entities/order_entity.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/repositories/shop_repository.dart';
import '../datasources/remote/hopkid_demo_data.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ApiClient _apiClient;
  final List<OrderEntity> _orders = List<OrderEntity>.from(
    HopkidDemoData.initialOrders,
  );

  ShopRepositoryImpl(this._apiClient);

  @override
  Future<List<Category>> getCategories() async {
    if (_apiClient.isConfigured) {
      // Ready for live REST API response mapping
      await _apiClient.get<dynamic>('/categories');
    }
    return HopkidDemoData.categories;
  }

  @override
  Future<List<Product>> getProducts({
    String? categoryId,
    String? subCategory,
    String? query,
    String? sortBy,
    int page = 1,
    int limit = 20,
  }) async {
    if (_apiClient.isConfigured) {
      await _apiClient.get<dynamic>(
        '/products',
        queryParameters: {
          'category': ?categoryId,
          'subCategory': ?subCategory,
          'q': ?query,
          'sort': ?sortBy,
          'page': page,
          'limit': limit,
        },
      );
    }

    var list = List<Product>.from(HopkidDemoData.products);
    if (categoryId != null && categoryId.isNotEmpty && categoryId != 'all') {
      list = list.where((p) => p.categoryId == categoryId).toList();
    }
    if (subCategory != null && subCategory.isNotEmpty && subCategory != 'All') {
      list = list.where((p) => p.subCategory == subCategory).toList();
    }
    if (query != null && query.trim().isNotEmpty) {
      final q = query.trim().toLowerCase();
      list = list.where((p) => p.name.toLowerCase().contains(q)).toList();
    }
    if (sortBy == 'price_asc') {
      list.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortBy == 'price_desc') {
      list.sort((a, b) => b.price.compareTo(a.price));
    } else if (sortBy == 'rating') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }
    return list;
  }

  @override
  Future<Product> getProductById(String id) async {
    return HopkidDemoData.products.firstWhere(
      (p) => p.id == id,
      orElse: () => HopkidDemoData.products.first,
    );
  }

  @override
  Future<List<Coupon>> getCoupons() async {
    if (_apiClient.isConfigured) {
      await _apiClient.get<dynamic>('/coupons');
    }
    return HopkidDemoData.coupons;
  }

  @override
  Future<List<OrderEntity>> getOrders({OrderStatus? filter}) async {
    if (_apiClient.isConfigured) {
      await _apiClient.get<dynamic>('/orders');
    }
    if (filter == null) return List.unmodifiable(_orders);
    return _orders.where((o) => o.status == filter).toList();
  }

  @override
  Future<OrderEntity> getOrderTracking(String orderId) async {
    return _orders.firstWhere(
      (o) => o.id == orderId,
      orElse: () => _orders.first,
    );
  }

  @override
  Future<OrderEntity> placeOrder({
    required double totalAmount,
    required String address,
    required String paymentMethod,
    required String deliveryOption,
    required String primaryProductName,
    required String primaryProductImage,
    required int totalQuantity,
  }) async {
    if (_apiClient.isConfigured) {
      await _apiClient.post<dynamic>(
        '/orders',
        data: {
          'totalAmount': totalAmount,
          'address': address,
          'paymentMethod': paymentMethod,
          'deliveryOption': deliveryOption,
        },
      );
    }

    final newOrder = OrderEntity(
      id: '#HPK2469',
      productName: primaryProductName,
      productImage: primaryProductImage,
      price: totalAmount,
      quantity: totalQuantity,
      status: OrderStatus.processing,
      orderDate: 'Nov 26, 2026',
      trackingSteps: const [
        TrackingStep(
          title: 'Order Placed',
          date: 'Nov 26, 2026',
          time: 'Just now',
          isCompleted: true,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Processing',
          date: 'Nov 26, 2026',
          time: 'In progress',
          isCompleted: true,
          isCurrent: true,
        ),
        TrackingStep(
          title: 'Shipped',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Out for Delivery',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
        TrackingStep(
          title: 'Delivered',
          date: 'Pending',
          time: '--',
          isCompleted: false,
          isCurrent: false,
        ),
      ],
    );
    _orders.insert(0, newOrder);
    return newOrder;
  }

  @override
  Future<UserProfile> getProfile() async {
    if (_apiClient.isConfigured) {
      await _apiClient.get<dynamic>('/profile');
    }
    return HopkidDemoData.defaultProfile;
  }
}
