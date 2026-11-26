class Product {
  final String id;
  final String name;
  final String categoryId;
  final String subCategory;
  final double price;
  final double originalPrice;
  final String? discountLabel;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final List<String> sizes;
  final String description;
  final int stockCount;

  const Product({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.subCategory,
    required this.price,
    required this.originalPrice,
    this.discountLabel,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.sizes,
    required this.description,
    required this.stockCount,
  });

  bool get inStock => stockCount > 0;
}
