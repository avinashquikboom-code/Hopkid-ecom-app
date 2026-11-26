class AddressEntity {
  final String id;
  final String title;
  final String fullAddress;
  final String phone;
  final bool isDefault;

  const AddressEntity({
    required this.id,
    required this.title,
    required this.fullAddress,
    required this.phone,
    this.isDefault = false,
  });
}

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final List<AddressEntity> addresses;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.addresses,
  });
}
