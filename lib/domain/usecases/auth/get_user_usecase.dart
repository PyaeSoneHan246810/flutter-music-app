import 'package:dartz/dartz.dart';
import 'package:music_app/core/usecase/usecase.dart';
import 'package:music_app/domain/repository/auth/auth_repository.dart';
import 'package:music_app/service_locator.dart';

class GetUserUsecase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await serviceLocator<AuthRepository>().getuser();
  }
}
