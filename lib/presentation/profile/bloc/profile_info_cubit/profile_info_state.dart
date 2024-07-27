part of 'profile_info_cubit.dart';

@immutable
sealed class ProfileInfoState {}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded({
    required this.userEntity,
  });
}

final class ProfileInfoFailure extends ProfileInfoState {
  final String errorMessage;
  ProfileInfoFailure({
    required this.errorMessage,
  });
}
