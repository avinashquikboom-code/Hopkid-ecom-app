import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../viewmodels/offers_viewmodel.dart';

class OffersScreen extends ConsumerWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offersAsync = ref.watch(offersViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: const HopkidAppBar(title: 'Offers & Deals'),
      body: SafeArea(
        child: offersAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: () => ref.read(offersViewModelProvider.notifier).refresh(),
          ),
          data: (coupons) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ResponsiveContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Promotional Banner
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'SEASONAL CELEBRATION',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white70,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  'Up to 40% OFF on Kids Fashion',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              'assets/images/banners/offers_banner.jpg',
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Available Coupons',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: coupons.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, idx) {
                        final coupon = coupons[idx];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 48,
                                width: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.lightPurple,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: const Icon(
                                  Icons.confirmation_number_outlined,
                                  color: AppColors.primaryPurple,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lavender,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            coupon.code,
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w800,
                                              color: AppColors.primaryPurple,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(
                                              ClipboardData(text: coupon.code),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Copied ${coupon.code}',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Icon(
                                            Icons.copy_rounded,
                                            size: 15,
                                            color: AppColors.secondaryText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      coupon.description,
                                      style: const TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      coupon.expiryDate,
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        color: AppColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  final applied = ref
                                      .read(cartViewModelProvider.notifier)
                                      .applyCoupon(coupon);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        applied
                                            ? 'Coupon ${coupon.code} applied to cart!'
                                            : 'Minimum order ₹${coupon.minOrderAmount.toInt()} required.',
                                      ),
                                    ),
                                  );
                                  if (applied && context.canPop()) {
                                    context.pop();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(86, 38),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                ),
                                child: const Text(
                                  'Use Code',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
