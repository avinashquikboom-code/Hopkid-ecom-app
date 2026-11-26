import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/badges_and_price.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/selectors.dart';
import '../../../core/widgets/state_widgets.dart';
import '../viewmodels/cart_viewmodel.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartViewModelProvider);
    final vm = ref.read(cartViewModelProvider.notifier);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: 'My Cart (${cart.totalCount})',
        showBack: Navigator.of(context).canPop(),
      ),
      body: SafeArea(
        child: cart.items.isEmpty
            ? EmptyStateWidget(
                icon: AppIcons.cartLine,
                title: 'Your Hopkid cart is empty',
                subtitle: 'Explore cute outfits & toys for your little ones.',
                actionLabel: 'Start Shopping',
                onAction: () => context.go('/home'),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ResponsiveContainer(
                  child: isTablet
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _CartItemsList(cart: cart, vm: vm),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              flex: 4,
                              child: _CartSummaryPanel(cart: cart, vm: vm),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _CartItemsList(cart: cart, vm: vm),
                            const SizedBox(height: 16),
                            _CartSummaryPanel(cart: cart, vm: vm),
                          ],
                        ),
                ),
              ),
      ),
    );
  }
}

class _CartItemsList extends StatelessWidget {
  final CartState cart;
  final CartViewModel vm;

  const _CartItemsList({required this.cart, required this.vm});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cart.items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, idx) {
        final item = cart.items[idx];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              HopkidImage(
                imageUrl: item.product.images.first,
                width: 84,
                height: 84,
                borderRadius: BorderRadius.circular(14),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(
                            AppIcons.delete,
                            size: 19,
                            color: AppColors.secondaryText,
                          ),
                          onPressed: () =>
                              vm.removeItem(item.product.id, item.selectedSize),
                        ),
                      ],
                    ),
                    Text(
                      'Size: ${item.selectedSize}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PriceWidget(
                          price: item.lineTotal,
                          originalPrice: item.lineOriginalTotal,
                          fontSize: 15,
                        ),
                        QuantitySelector(
                          compact: true,
                          quantity: item.quantity,
                          onDecrement: () =>
                              vm.decrement(item.product.id, item.selectedSize),
                          onIncrement: () =>
                              vm.increment(item.product.id, item.selectedSize),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CartSummaryPanel extends StatelessWidget {
  final CartState cart;
  final CartViewModel vm;

  const _CartSummaryPanel({required this.cart, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Apply Coupon Card
        InkWell(
          onTap: () => context.push('/offers'),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.lightPurple.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  AppIcons.coupon,
                  color: AppColors.primaryPurple,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    cart.appliedCoupon != null
                        ? 'Coupon ${cart.appliedCoupon!.code} applied'
                        : 'Apply Coupon',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
                if (cart.appliedCoupon != null)
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(AppIcons.close, size: 18),
                    onPressed: vm.removeCoupon,
                  )
                else
                  const Icon(
                    AppIcons.chevronRight,
                    color: AppColors.primaryPurple,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Order Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 12),
              _SummaryRow(
                label: 'Item Total',
                value: '${AppConstants.currencySymbol}${cart.itemTotal.toInt()}',
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'Discount',
                value:
                    '-${AppConstants.currencySymbol}${cart.discountAmount.toInt()}',
                valueColor: AppColors.success,
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: 'Delivery',
                value: cart.deliveryFee == 0
                    ? 'FREE'
                    : '${AppConstants.currencySymbol}${cart.deliveryFee.toInt()}',
                valueColor: cart.deliveryFee == 0 ? AppColors.success : null,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.border),
              ),
              _SummaryRow(
                label: 'Total Amount',
                value:
                    '${AppConstants.currencySymbol}${cart.totalAmount.toInt()}',
                isBold: true,
              ),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Proceed to Checkout',
                onPressed: () => context.push('/checkout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 15 : 13.5,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: isBold ? AppColors.primaryText : AppColors.secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 17 : 13.5,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
            color: valueColor ?? AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
