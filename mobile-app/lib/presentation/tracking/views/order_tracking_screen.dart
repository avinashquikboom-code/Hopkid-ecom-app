import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/badges_and_price.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../viewmodels/order_tracking_viewmodel.dart';

class OrderTrackingScreen extends ConsumerStatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  ConsumerState<OrderTrackingScreen> createState() =>
      _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends ConsumerState<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(orderTrackingViewModelProvider.notifier)
          .loadTracking(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final trackingAsync = ref.watch(orderTrackingViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const HopkidAppBar(title: 'Track Order'),
      body: SafeArea(
        child: trackingAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: () => ref
                .read(orderTrackingViewModelProvider.notifier)
                .loadTracking(widget.orderId),
          ),
          data: (order) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ResponsiveContainer(
                child: Column(
                  children: [
                    // Order Summary Card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          HopkidImage(
                            imageUrl: order.productImage,
                            width: 74,
                            height: 74,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.id,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryPurple,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  order.productName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${AppConstants.currencySymbol}${order.price.toInt()}  •  Qty: ${order.quantity}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Timeline Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Order Timeline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryText,
                            ),
                          ),
                          const SizedBox(height: 18),
                          ...List.generate(order.trackingSteps.length, (idx) {
                            final step = order.trackingSteps[idx];
                            final isLast = idx == order.trackingSteps.length - 1;
                            final Color dotColor = step.isCurrent
                                ? AppColors.primaryPurple
                                : step.isCompleted
                                    ? AppColors.success
                                    : AppColors.border;

                            final IconData stepIcon = step.isCurrent
                                ? AppIcons.shippingFill
                                : step.isCompleted
                                    ? AppIcons.check
                                    : AppIcons.circleLine;

                            return IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: step.isCompleted || step.isCurrent
                                              ? dotColor
                                              : AppColors.lightBackground,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: dotColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          stepIcon,
                                          size: 16,
                                          color: step.isCompleted || step.isCurrent
                                              ? Colors.white
                                              : AppColors.secondaryText,
                                        ),
                                      ),
                                      if (!isLast)
                                        Expanded(
                                          child: Container(
                                            width: 2,
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            color: step.isCompleted
                                                ? AppColors.success
                                                : AppColors.border,
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 22),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                step.title,
                                                style: TextStyle(
                                                  fontSize: 14.5,
                                                  fontWeight: step.isCurrent
                                                      ? FontWeight.w800
                                                      : FontWeight.w700,
                                                  color: step.isCompleted ||
                                                          step.isCurrent
                                                      ? AppColors.primaryText
                                                      : AppColors.secondaryText,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                step.date,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.secondaryText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            step.time,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
