import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/order_entity.dart';

class OrdersState {
  final OrderStatus? filter;
  final List<OrderEntity> orders;

  const OrdersState({
    this.filter,
    this.orders = const [],
  });
}

class OrdersViewModel extends AsyncNotifier<OrdersState> {
  OrderStatus? _selectedFilter;

  @override
  Future<OrdersState> build() => _loadOrders();

  Future<OrdersState> _loadOrders() async {
    final orders = await ref
        .read(shopRepositoryProvider)
        .getOrders(filter: _selectedFilter);
    return OrdersState(filter: _selectedFilter, orders: orders);
  }

  Future<void> setFilter(OrderStatus? status) async {
    _selectedFilter = status;
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadOrders);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_loadOrders);
  }
}

final ordersViewModelProvider =
    AsyncNotifierProvider<OrdersViewModel, OrdersState>(
  OrdersViewModel.new,
);
