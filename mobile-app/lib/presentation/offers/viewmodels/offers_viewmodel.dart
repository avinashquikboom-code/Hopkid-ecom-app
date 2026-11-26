import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/coupon.dart';

class OffersViewModel extends AsyncNotifier<List<Coupon>> {
  @override
  Future<List<Coupon>> build() {
    return ref.read(shopRepositoryProvider).getCoupons();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(shopRepositoryProvider).getCoupons(),
    );
  }
}

final offersViewModelProvider =
    AsyncNotifierProvider<OffersViewModel, List<Coupon>>(
  OffersViewModel.new,
);
