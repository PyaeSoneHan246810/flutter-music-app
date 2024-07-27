import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/domain/entities/auth/user.dart';
import 'package:music_app/domain/usecases/auth/get_user_usecase.dart';
import 'package:music_app/service_locator.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoInitial());
  Future<void> getUser() async {
    emit(ProfileInfoLoading());
    var response = await serviceLocator<GetUserUsecase>().call();
    response.fold(
      (errorMessage) {
        emit(ProfileInfoFailure(errorMessage: errorMessage));
      },
      (userEntity) {
        emit(ProfileInfoLoaded(userEntity: userEntity));
      },
    );
  }
}
