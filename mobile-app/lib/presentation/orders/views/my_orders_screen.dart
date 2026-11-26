import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/widgets/badges_and_price.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../../domain/entities/order_entity.dart';
import '../viewmodels/orders_viewmodel.dart';

class MyOrdersScreen extends ConsumerWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersViewModelProvider);
    final vm = ref.read(ordersViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: 'My Orders',
        showBack: Navigator.of(context).canPop(),
      ),
      body: SafeArea(
        child: ordersAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: vm.refresh,
          ),
          data: (state) {
            return RefreshIndicator(
              color: AppColors.primaryPurple,
              onRefresh: vm.refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: ResponsiveContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Chips
                      SizedBox(
                        height: 38,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _OrderFilterChip(
                              label: 'All',
                              selected: state.filter == null,
                              onTap: () => vm.setFilter(null),
                            ),
                            const SizedBox(width: 8),
                            _OrderFilterChip(
                              label: 'Processing',
                              selected: state.filter == OrderStatus.processing,
                              onTap: () => vm.setFilter(OrderStatus.processing),
                            ),
                            const SizedBox(width: 8),
                            _OrderFilterChip(
                              label: 'Shipped',
                              selected: state.filter == OrderStatus.shipped,
                              onTap: () => vm.setFilter(OrderStatus.shipped),
                            ),
                            const SizedBox(width: 8),
                            _OrderFilterChip(
                              label: 'Delivered',
                              selected: state.filter == OrderStatus.delivered,
                              onTap: () => vm.setFilter(OrderStatus.delivered),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (state.orders.isEmpty)
                        EmptyStateWidget(
                          icon: AppIcons.ordersLine,
                          title: 'No orders found',
                          subtitle: 'Orders matching this status will appear here.',
                          actionLabel: 'Explore Shop',
                          onAction: () => context.go('/home'),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.orders.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 12),
                          itemBuilder: (context, idx) {
                            final order = state.orders[idx];
                            return InkWell(
                              onTap: () => context.push(
                                '/tracking/${Uri.encodeComponent(order.id)}',
                              ),
                              borderRadius: BorderRadius.circular(18),
                              child: Container(
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
                                      width: 72,
                                      height: 72,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                order.id,
                                                style: const TextStyle(
                                                  fontSize: 12.5,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColors.primaryPurple,
                                                ),
                                              ),
                                              _StatusBadge(status: order.status),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            order.productName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primaryText,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${AppConstants.currencySymbol}${order.price.toInt()}  •  Qty: ${order.quantity}',
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.secondaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    const Icon(
                                      AppIcons.chevronRight,
                                      color: AppColors.secondaryText,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _OrderFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OrderFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.primaryPurple,
      backgroundColor: AppColors.surface,
      side: BorderSide(
        color: selected ? AppColors.primaryPurple : AppColors.border,
      ),
      labelStyle: TextStyle(
        fontSize: 12.5,
        fontWeight: FontWeight.w700,
        color: selected ? Colors.white : AppColors.primaryText,
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final OrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (status) {
      OrderStatus.delivered => (
          'Delivered',
          AppColors.greenPastel,
          const Color(0xFF15803D)
        ),
      OrderStatus.shipped => (
          'Shipped',
          AppColors.bluePastel,
          const Color(0xFF1D4ED8)
        ),
      OrderStatus.processing => (
          'Processing',
          AppColors.orangePastel,
          const Color(0xFFB45309)
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}
