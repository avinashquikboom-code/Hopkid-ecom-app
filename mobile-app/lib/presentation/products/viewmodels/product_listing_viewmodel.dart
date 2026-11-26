import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/product.dart';

class ProductListingState {
  final String categoryId;
  final String selectedSubCategory;
  final String sortBy;
  final String searchQuery;
  final List<Product> products;

  const ProductListingState({
    this.categoryId = 'boys',
    this.selectedSubCategory = 'All',
    this.sortBy = 'popular',
    this.searchQuery = '',
    this.products = const [],
  });

  ProductListingState copyWith({
    String? categoryId,
    String? selectedSubCategory,
    String? sortBy,
    String? searchQuery,
    List<Product>? products,
  }) {
    return ProductListingState(
      categoryId: categoryId ?? this.categoryId,
      selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
      sortBy: sortBy ?? this.sortBy,
      searchQuery: searchQuery ?? this.searchQuery,
      products: products ?? this.products,
    );
  }
}

class ProductListingViewModel extends AsyncNotifier<ProductListingState> {
  @override
  Future<ProductListingState> build() async {
    return _fetch(const ProductListingState());
  }

  Future<ProductListingState> _fetch(ProductListingState current) async {
    final items = await ref.read(getProductsUseCaseProvider).call(
          categoryId: current.categoryId,
          subCategory: current.selectedSubCategory,
          query: current.searchQuery,
          sortBy: current.sortBy,
        );
    return current.copyWith(products: items);
  }

  Future<void> setCategory(String categoryId) async {
    final current = state.value ?? const ProductListingState();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetch(current.copyWith(categoryId: categoryId, selectedSubCategory: 'All')),
    );
  }

  Future<void> selectSubCategory(String subCategory) async {
    final current = state.value ?? const ProductListingState();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetch(current.copyWith(selectedSubCategory: subCategory)),
    );
  }

  Future<void> setSortBy(String sortBy) async {
    final current = state.value ?? const ProductListingState();
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _fetch(current.copyWith(sortBy: sortBy)),
    );
  }

  Future<void> search(String query) async {
    final current = state.value ?? const ProductListingState();
    state = await AsyncValue.guard(
      () => _fetch(current.copyWith(searchQuery: query)),
    );
  }
}

final productListingViewModelProvider =
    AsyncNotifierProvider<ProductListingViewModel, ProductListingState>(
  ProductListingViewModel.new,
);
