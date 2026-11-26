import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/local/hopkid_local_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/shop_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/usecases/shop_usecases.dart';
import '../network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final localStorageProvider = Provider<HopkidLocalStorage>(
  (ref) => HopkidLocalStorage(),
);

final shopRepositoryProvider = Provider<ShopRepository>((ref) {
  return ShopRepositoryImpl(ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(apiClientProvider),
    ref.watch(localStorageProvider),
  );
});

final getCategoriesUseCaseProvider = Provider<GetCategoriesUseCase>(
  (ref) => GetCategoriesUseCase(ref.watch(shopRepositoryProvider)),
);

final getProductsUseCaseProvider = Provider<GetProductsUseCase>(
  (ref) => GetProductsUseCase(ref.watch(shopRepositoryProvider)),
);

final validateCouponUseCaseProvider = Provider<ValidateCouponUseCase>(
  (ref) => const ValidateCouponUseCase(),
);

final placeOrderUseCaseProvider = Provider<PlaceOrderUseCase>(
  (ref) => PlaceOrderUseCase(ref.watch(shopRepositoryProvider)),
);
