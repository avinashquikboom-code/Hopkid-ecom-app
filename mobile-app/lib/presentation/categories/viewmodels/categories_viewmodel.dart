import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/category.dart';

class CategoriesViewModel extends AsyncNotifier<List<Category>> {
  @override
  Future<List<Category>> build() {
    return ref.read(getCategoriesUseCaseProvider).call();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(getCategoriesUseCaseProvider).call(),
    );
  }
}

final categoriesViewModelProvider =
    AsyncNotifierProvider<CategoriesViewModel, List<Category>>(
  CategoriesViewModel.new,
);
