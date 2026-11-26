import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/product.dart';

class HomeData {
  final List<Category> shortcuts;
  final List<Product> trendingProducts;
  final String searchQuery;

  const HomeData({
    required this.shortcuts,
    required this.trendingProducts,
    this.searchQuery = '',
  });

  HomeData copyWith({
    List<Category>? shortcuts,
    List<Product>? trendingProducts,
    String? searchQuery,
  }) {
    return HomeData(
      shortcuts: shortcuts ?? this.shortcuts,
      trendingProducts: trendingProducts ?? this.trendingProducts,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class HomeViewModel extends AsyncNotifier<HomeData> {
  @override
  Future<HomeData> build() => _loadHome();

  Future<HomeData> _loadHome({String query = ''}) async {
    final categories = await ref.read(getCategoriesUseCaseProvider).call();
    final products = await ref.read(getProductsUseCaseProvider).call(
          query: query.isEmpty ? null : query,
        );
    return HomeData(
      shortcuts: categories.where((c) => c.isShortcut).toList(),
      trendingProducts: products,
      searchQuery: query,
    );
  }

  Future<void> search(String query) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _loadHome(query: query));
  }

  Future<void> refresh() async {
    final currentQuery = state.value?.searchQuery ?? '';
    state = await AsyncValue.guard(() => _loadHome(query: currentQuery));
  }
}

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeData>(
  HomeViewModel.new,
);
