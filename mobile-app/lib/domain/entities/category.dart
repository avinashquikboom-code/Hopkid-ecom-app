class Category {
  final String id;
  final String name;
  final String iconName;
  final int bgColorHex;
  final bool isShortcut;

  const Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.bgColorHex,
    this.isShortcut = false,
  });
}
