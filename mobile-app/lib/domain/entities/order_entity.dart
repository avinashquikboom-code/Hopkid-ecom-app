enum OrderStatus {
  processing,
  shipped,
  delivered,
}

class TrackingStep {
  final String title;
  final String date;
  final String time;
  final bool isCompleted;
  final bool isCurrent;

  const TrackingStep({
    required this.title,
    required this.date,
    required this.time,
    required this.isCompleted,
    required this.isCurrent,
  });
}

class OrderEntity {
  final String id;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;
  final OrderStatus status;
  final String orderDate;
  final List<TrackingStep> trackingSteps;

  const OrderEntity({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.status,
    required this.orderDate,
    required this.trackingSteps,
  });
}
