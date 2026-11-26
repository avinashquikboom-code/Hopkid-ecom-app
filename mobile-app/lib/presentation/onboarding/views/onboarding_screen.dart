import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/providers.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/responsive_container.dart';

class _OnboardingSlide {
  final String title;
  final String description;
  final String imageAsset;

  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.imageAsset,
  });
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      title: 'Shop for Your Little Ones',
      description:
          "Discover a wide range of kids' fashion, toys, baby care and more — all in one place!",
      imageAsset: 'assets/images/onboarding/onboarding_bag.jpg',
    ),
    _OnboardingSlide(
      title: 'Soft Fabrics & Playful Styles',
      description:
          'Curated 100% breathable cotton outfits crafted for comfort, durability, and everyday celebrations.',
      imageAsset: 'assets/images/banners/offers_banner.jpg',
    ),
    _OnboardingSlide(
      title: 'Fast Delivery & Easy Returns',
      description:
          'Enjoy free shipping above ₹999, hassle-free size exchanges, and live order tracking.',
      imageAsset: 'assets/images/banners/home_banner_kids.jpg',
    ),
  ];

  Future<void> _finishOnboarding() async {
    await ref.read(authRepositoryProvider).markOnboardingSeen();
    if (!mounted) return;
    context.go('/auth');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightPurple,
      body: SafeArea(
        child: ResponsiveContainer(
          child: Column(
            children: [
              // Skip Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _finishOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ),
              ),

              // Swipeable Pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: constraints.maxHeight * 0.48,
                                  constraints: const BoxConstraints(
                                    maxWidth: 360,
                                    maxHeight: 340,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primaryPurple
                                            .withValues(alpha: 0.12),
                                        blurRadius: 24,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(32),
                                    child: Image.asset(
                                      slide.imageAsset,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 12,
                                  right: 16,
                                  child: Icon(
                                    Icons.auto_awesome_rounded,
                                    color: AppColors.warning,
                                    size: 28,
                                  ),
                                ),
                                const Positioned(
                                  bottom: 14,
                                  left: 18,
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: AppColors.primaryPurple,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 28),
                            Text(
                              slide.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryText,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 400),
                              child: Text(
                                slide.description,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  height: 1.5,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),

              // Page Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (index) {
                  final active = index == _currentPage;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: active ? 24 : 8,
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primaryPurple
                          : AppColors.primaryPurple.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(99),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: PrimaryButton(
                  label: _currentPage == _slides.length - 1
                      ? 'Get Started'
                      : 'Get Started',
                  onPressed: _finishOnboarding,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
