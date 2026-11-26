import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/hopkid_app_bar.dart';
import '../../../core/widgets/responsive_container.dart';
import '../../../core/widgets/state_widgets.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../viewmodels/profile_viewmodel.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: HopkidAppBar(
        title: 'My Account',
        showBack: Navigator.of(context).canPop(),
      ),
      body: SafeArea(
        child: profileAsync.when(
          loading: () => const LoadingWidget(),
          error: (err, _) => HopkidErrorWidget(
            message: err.toString(),
            onRetry: () => ref.read(profileViewModelProvider.notifier).refresh(),
          ),
          data: (profile) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ResponsiveContainer(
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.lightPurple, AppColors.pink],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.primaryPurple,
                            child: Text(
                              profile.name
                                  .split(' ')
                                  .map((e) => e.isNotEmpty ? e[0] : '')
                                  .take(2)
                                  .join(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profile.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryText,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  profile.phone,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                                Text(
                                  profile.email,
                                  style: const TextStyle(
                                    fontSize: 12.5,
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

                    // Menu Items
                    _AccountMenuTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'My Orders',
                      onTap: () => context.go('/orders'),
                    ),
                    _AccountMenuTile(
                      icon: Icons.favorite_border_rounded,
                      title: 'My Wishlist',
                      onTap: () => context.push('/wishlist'),
                    ),
                    _AccountMenuTile(
                      icon: Icons.location_on_outlined,
                      title: 'Addresses',
                      onTap: () => context.push('/checkout'),
                    ),
                    _AccountMenuTile(
                      icon: Icons.credit_card_outlined,
                      title: 'Payment Methods',
                      onTap: () => context.push('/checkout'),
                    ),
                    _AccountMenuTile(
                      icon: Icons.local_offer_outlined,
                      title: 'Coupons & Offers',
                      onTap: () => context.push('/offers'),
                    ),
                    _AccountMenuTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Notification preferences are up to date.'),
                        ),
                      ),
                    ),
                    _AccountMenuTile(
                      icon: Icons.support_agent_rounded,
                      title: 'Help & Support',
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hopkid Care: support@hopkid.in'),
                        ),
                      ),
                    ),
                    _AccountMenuTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About Hopkid',
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hopkid by Little Laugh • v1.0.0'),
                        ),
                      ),
                    ),
                    _AccountMenuTile(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      isDestructive: true,
                      onTap: () async {
                        await ref.read(authViewModelProvider.notifier).logout();
                        if (context.mounted) context.go('/auth');
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

class _AccountMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _AccountMenuTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.primaryPurple;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.lightPurple,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: isDestructive
                          ? AppColors.error
                          : AppColors.primaryText,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
