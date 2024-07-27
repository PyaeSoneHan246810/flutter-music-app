import 'package:dartz/dartz.dart';
import 'package:music_app/data/data_sources/auth/auth_data_source.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/domain/repository/auth/auth_repository.dart';
import 'package:music_app/service_locator.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    return await serviceLocator<AuthDataSource>().signUp(createUserReq);
  }

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    return await serviceLocator<AuthDataSource>().signIn(signInUserReq);
  }

  @override
  Future<Either> getuser() async {
    return await serviceLocator<AuthDataSource>().getUser();
  }
}
