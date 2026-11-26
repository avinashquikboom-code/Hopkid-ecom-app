import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import '../constants/app_colors.dart';
import '../constants/app_icons.dart';
import '../theme/app_typography.dart';

/// Platform-independent Hopkid AppBar that renders identically on
/// Android, iOS, iPadOS, and Web without platform-specific title alignment
/// or back-button differences.
class HopkidAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool centerTitle;

  const HopkidAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.onBack,
    this.actions,
    this.titleWidget,
    this.centerTitle = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(57);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        color: AppColors.surface,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              bottom: false,
              child: SizedBox(
                height: 56,
                child: NavigationToolbar(
                  centerMiddle: centerTitle,
                  middleSpacing: 8,
                  leading: showBack
                      ? SizedBox(
                          width: 48,
                          height: 48,
                          child: IconButton(
                            icon: const Icon(AppIcons.back, size: 22),
                            color: AppColors.primaryText,
                            tooltip: 'Back',
                            onPressed:
                                onBack ?? () => Navigator.of(context).maybePop(),
                          ),
                        )
                      : null,
                  middle: titleWidget ??
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.title.copyWith(fontSize: 18),
                      ),
                  trailing: actions != null && actions!.isNotEmpty
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: actions!,
                        )
                      : null,
                ),
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.border),
          ],
        ),
      ),
    );
  }
}
