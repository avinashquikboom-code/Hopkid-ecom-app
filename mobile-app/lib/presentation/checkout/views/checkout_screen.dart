import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../viewmodels/checkout_viewmodel.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  void _showEditAddressDialog(
    BuildContext context,
    CheckoutState state,
    CheckoutViewModel vm,
  ) {
    final titleCtrl = TextEditingController(text: state.addressTitle);
    final lineCtrl = TextEditingController(text: state.addressLine);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Delivery Address'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: const InputDecoration(labelText: 'Label (e.g. Home)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: lineCtrl,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Full Address'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              vm.updateAddress(titleCtrl.text, lineCtrl.text);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(90, 40)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkout = ref.watch(checkoutViewModelProvider);
    final vm = ref.read(checkoutViewModelProvider.notifier);
    final cart = ref.watch(cartViewModelProvider);
    final isTablet = Responsive.isTablet(context);

    final payable =
        (cart.itemTotal - cart.discountAmount + checkout.extraDeliveryFee)
            .clamp(0, double.infinity);

    final leftColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Delivery Address
        _SectionCard(
          title: 'Delivery Address',
          trailing: TextButton(
            onPressed: () => _showEditAddressDialog(context, checkout, vm),
            child: const Text(
              'Edit',
              style: TextStyle(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_rounded,
                color: AppColors.primaryPurple,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checkout.addressTitle,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      checkout.addressLine,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.secondaryText,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Delivery Options
        _SectionCard(
          title: 'Delivery Options',
          child: Column(
            children: [
              _DeliveryTile(
                title: 'Standard Delivery (3–5 Business Days)',
                priceLabel: 'Free',
                priceColor: AppColors.success,
                selected: checkout.deliveryOption == DeliveryOption.standard,
                onTap: () => vm.selectDelivery(DeliveryOption.standard),
              ),
              const SizedBox(height: 8),
              _DeliveryTile(
                title: 'Express Delivery (1–2 Business Days)',
                priceLabel: '₹49',
                selected: checkout.deliveryOption == DeliveryOption.express,
                onTap: () => vm.selectDelivery(DeliveryOption.express),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Payment Method
        _SectionCard(
          title: 'Payment Method',
          child: Column(
            children: [
              _PaymentTile(
                title: 'UPI (GPay, PhonePe, Paytm)',
                icon: Icons.account_balance_wallet_outlined,
                value: PaymentMethod.upi,
                groupValue: checkout.paymentMethod,
                onChanged: vm.selectPayment,
              ),
              _PaymentTile(
                title: 'Credit / Debit Card',
                icon: Icons.credit_card_rounded,
                value: PaymentMethod.card,
                groupValue: checkout.paymentMethod,
                onChanged: vm.selectPayment,
              ),
              _PaymentTile(
                title: 'Net Banking',
                icon: Icons.account_balance_outlined,
                value: PaymentMethod.netBanking,
                groupValue: checkout.paymentMethod,
                onChanged: vm.selectPayment,
              ),
              _PaymentTile(
                title: 'Cash on Delivery',
                icon: Icons.payments_outlined,
                value: PaymentMethod.cod,
                groupValue: checkout.paymentMethod,
                onChanged: vm.selectPayment,
              ),
            ],
          ),
        ),
      ],
    );

    final summaryColumn = _SectionCard(
      title: 'Order Summary',
      child: Column(
        children: [
          _SummaryLine('Item Total', '${AppConstants.currencySymbol}${cart.itemTotal.toInt()}'),
          const SizedBox(height: 8),
          _SummaryLine(
            'Discount',
            '-${AppConstants.currencySymbol}${cart.discountAmount.toInt()}',
            color: AppColors.success,
          ),
          const SizedBox(height: 8),
          _SummaryLine(
            'Delivery',
            checkout.extraDeliveryFee == 0
                ? 'Free'
                : '${AppConstants.currencySymbol}${checkout.extraDeliveryFee.toInt()}',
            color: checkout.extraDeliveryFee == 0 ? AppColors.success : null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.border),
          ),
          _SummaryLine(
            'Total Amount',
            '${AppConstants.currencySymbol}${payable.toInt()}',
            isBold: true,
          ),
          if (checkout.errorMessage != null) ...[
            const SizedBox(height: 12),
            Text(
              checkout.errorMessage!,
              style: const TextStyle(color: AppColors.error, fontSize: 12.5),
            ),
          ],
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'Pay ${AppConstants.currencySymbol}${payable.toInt()}',
            isLoading: checkout.isPlacingOrder,
            onPressed: () async {
              final order = await vm.placeOrder();
              if (order != null && context.mounted) {
                context.go('/order-success/${Uri.encodeComponent(order.id)}');
              }
            },
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const HopkidAppBar(title: 'Checkout'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ResponsiveContainer(
            child: isTablet
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: leftColumn),
                      const SizedBox(width: 24),
                      Expanded(flex: 4, child: summaryColumn),
                    ],
                  )
                : Column(
                    children: [
                      leftColumn,
                      const SizedBox(height: 14),
                      summaryColumn,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? trailing;

  const _SectionCard({
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _DeliveryTile extends StatelessWidget {
  final String title;
  final String priceLabel;
  final Color? priceColor;
  final bool selected;
  final VoidCallback onTap;

  const _DeliveryTile({
    required this.title,
    required this.priceLabel,
    this.priceColor,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.lightPurple.withValues(alpha: 0.45) : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primaryPurple : AppColors.border,
          ),
        ),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? AppColors.primaryPurple : AppColors.secondaryText,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              priceLabel,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: priceColor ?? AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final PaymentMethod value;
  final PaymentMethod groupValue;
  final ValueChanged<PaymentMethod> onChanged;

  const _PaymentTile({
    required this.title,
    required this.icon,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected ? AppColors.primaryPurple : AppColors.secondaryText,
              size: 20,
            ),
            const SizedBox(width: 12),
            Icon(icon, color: AppColors.primaryPurple, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final bool isBold;

  const _SummaryLine(
    this.label,
    this.value, {
    this.color,
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
            color: color ?? AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
