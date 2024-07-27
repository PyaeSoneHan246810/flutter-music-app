import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/domain/repository/auth/auth_repository.dart';
import 'package:music_app/service_locator.dart';

class SignUpUsecase implements UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) {
    return serviceLocator<AuthRepository>().signUp(params!);
  }
}
