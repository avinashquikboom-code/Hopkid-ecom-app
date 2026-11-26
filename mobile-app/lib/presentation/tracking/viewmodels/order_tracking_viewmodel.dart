import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/order_entity.dart';

class OrderTrackingViewModel extends Notifier<AsyncValue<OrderEntity>> {
  @override
  AsyncValue<OrderEntity> build() => const AsyncLoading();

  Future<void> loadTracking(String orderId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(shopRepositoryProvider).getOrderTracking(orderId),
    );
  }
}

final orderTrackingViewModelProvider =
    NotifierProvider<OrderTrackingViewModel, AsyncValue<OrderEntity>>(
  OrderTrackingViewModel.new,
);
