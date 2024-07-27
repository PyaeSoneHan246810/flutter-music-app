import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/domain/repository/auth/auth_repository.dart';
import 'package:music_app/service_locator.dart';

class SignInUsecase implements UseCase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) async {
    return serviceLocator<AuthRepository>().signIn(params!);
  }
}
