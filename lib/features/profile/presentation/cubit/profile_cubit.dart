import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repos/profile_repo.dart';
import '../../domain/usecases/delete_account_use_case.dart';
import '../../domain/usecases/get_profile_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final DeleteAccountUseCase? deleteAccountUseCase;

  ProfileCubit(
      this.repo, {
        required this.getProfileUseCase,
        required this.updateProfileUseCase,
        this.deleteAccountUseCase,
      }) : super(const ProfileInitial());

  Future<void> getProfile(String token) async {
    emit(const ProfileLoading());

    try {
      print('📞 Getting profile with token: $token');

      if (token.isEmpty) {
        print('❌ Token is empty');
        emit(const ProfileError('Token is missing. Please login again.'));
        return;
      }

      final result = await getProfileUseCase(token);

      await result.fold(
            (failure) async {
          print('❌ Get profile failed: ${failure.message}');
          emit(ProfileError(failure.message ?? 'Failed to load profile'));
        },
            (profile) async {
          print('✅ Profile loaded: ${profile.name}');
          emit(ProfileLoaded(profile));
        },
      );
    } catch (e) {
      print('❌ Exception in getProfile: $e');
      emit(ProfileError('Error loading profile: $e'));
    }
  }

  Future<void> updateProfile(String token, ProfileEntity profile) async {
    emit(const ProfileLoading());

    try {
      print('📞 Updating profile...');
      print('   Token: $token');
      print('   Name: ${profile.name}');
      print('   Phone: ${profile.phone}');
      print('   Avatar: ${profile.avatarIndex}');

      if (token.isEmpty) {
        emit(const ProfileError('Token is missing. Please login again.'));
        return;
      }

      final result = await updateProfileUseCase(
        token: token,
        name: profile.name,
        phone: profile.phone,
        avatarIndex: profile.avatarIndex,
      );

      await result.fold(
            (failure) async {
          print('❌ Update failed: ${failure.message}');
          emit(ProfileError(failure.message ?? 'Failed to update profile'));
        },
            (updatedProfile) async {
          print('✅ Profile updated successfully');
          emit(ProfileLoaded(updatedProfile));
          await Future.delayed(const Duration(milliseconds: 500));
          emit(const ProfileActionSuccess('Profile updated successfully'));
        },
      );
    } catch (e) {
      print('❌ Exception in updateProfile: $e');
      emit(ProfileError('Error updating profile: $e'));
    }
  }

  Future<void> deleteAccount(String token) async {
    emit(const ProfileLoading());

    try {
      print('📞 Deleting account...');

      if (token.isEmpty) {
        emit(const ProfileError('Token is missing. Please login again.'));
        return;
      }

      if (deleteAccountUseCase == null) {
        emit(const ProfileError('Delete account feature not available'));
        return;
      }

      final result = await deleteAccountUseCase!(token);

      await result.fold(
            (failure) async {
          print('❌ Delete failed: ${failure.message}');
          emit(ProfileError(failure.message ?? 'Failed to delete account'));
        },
            (_) async {
          print('✅ Account deleted successfully');
          emit(const ProfileActionSuccess('Account deleted successfully'));
        },
      );
    } catch (e) {
      print('❌ Exception in deleteAccount: $e');
      emit(ProfileError('Error deleting account: $e'));
    }
  }
}
