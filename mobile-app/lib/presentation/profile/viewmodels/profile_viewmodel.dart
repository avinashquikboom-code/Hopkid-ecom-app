import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/providers.dart';
import '../../../domain/entities/user_profile.dart';

class ProfileViewModel extends AsyncNotifier<UserProfile> {
  @override
  Future<UserProfile> build() {
    return ref.read(shopRepositoryProvider).getProfile();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(shopRepositoryProvider).getProfile(),
    );
  }
}

final profileViewModelProvider =
    AsyncNotifierProvider<ProfileViewModel, UserProfile>(
  ProfileViewModel.new,
);
