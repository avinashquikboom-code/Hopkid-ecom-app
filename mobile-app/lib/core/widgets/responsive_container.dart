import 'package:material_ui/material_ui.dart';
import '../responsive/responsive.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final maxW = Responsive.maxContentWidth(width);
        final hPad = Responsive.horizontalPadding(width);

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxW),
            child: Padding(
              padding: padding ?? EdgeInsets.symmetric(horizontal: hPad),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final int Function(double width)? columnsForWidth;
  final double spacing;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.columnsForWidth,
    this.spacing = 14,
    this.childAspectRatio = 0.68,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (columnsForWidth ?? Responsive.productGridColumns)(
          constraints.maxWidth,
        );
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
