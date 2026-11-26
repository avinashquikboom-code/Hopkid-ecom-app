import 'package:material_ui/material_ui.dart';
import '../../domain/entities/category.dart';
import '../constants/app_colors.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(category.bgColorHex),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border.withValues(alpha: 0.7)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _iconForName(category.iconName),
                color: AppColors.primaryPurple,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconForName(String name) {
    switch (name) {
      case 'boy':
        return Icons.boy_rounded;
      case 'girl':
        return Icons.girl_rounded;
      case 'baby':
        return Icons.child_friendly_rounded;
      case 'toys':
        return Icons.toys_rounded;
      case 'ethnic':
        return Icons.auto_awesome_rounded;
      case 'accessories':
        return Icons.watch_rounded;
      case 'footwear':
        return Icons.ice_skating_rounded;
      case 'gear':
        return Icons.stroller_rounded;
      default:
        return Icons.category_rounded;
    }
  }
}
