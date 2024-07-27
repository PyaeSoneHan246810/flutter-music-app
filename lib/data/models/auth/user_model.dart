import 'package:music_app/domain/entities/auth/user.dart';

class UserModel {
  final String fullName;
  final String email;
  String imageUrl;
  UserModel({
    required this.fullName,
    required this.email,
    required this.imageUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map["username"],
      email: map["email"],
      imageUrl: "",
    );
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName,
      email: email,
      imageUrl: imageUrl,
    );
  }
}
