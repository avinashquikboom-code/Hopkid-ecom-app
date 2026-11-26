class Coupon {
  final String code;
  final String title;
  final String description;
  final double discountPercent;
  final double? maxDiscount;
  final double minOrderAmount;
  final String expiryDate;

  const Coupon({
    required this.code,
    required this.title,
    required this.description,
    required this.discountPercent,
    this.maxDiscount,
    required this.minOrderAmount,
    required this.expiryDate,
  });

  double calculateDiscount(double subtotal) {
    if (subtotal < minOrderAmount) return 0;
    final raw = subtotal * (discountPercent / 100);
    if (maxDiscount != null && raw > maxDiscount!) {
      return maxDiscount!;
    }
    return raw.roundToDouble();
  }
}
