import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_app/core/configs/constants/app_urls.dart';
import 'package:music_app/data/models/auth/create_user_req.dart';
import 'package:music_app/data/models/auth/signin_user_req.dart';
import 'package:music_app/data/models/auth/user_model.dart';

abstract class AuthDataSource {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SignInUserReq signInUserReq);
  Future<Either> getUser();
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<Either> signUp(CreateUserReq createUserReq) async {
    try {
      var userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user?.uid)
          .set({
        "id": userCredential.user?.uid,
        "email": userCredential.user?.email,
        "username": createUserReq.fullName,
      });
      return const Right("Successfully created an account.");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "weak-password") {
        message = "The password provided is too weak.";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with this email.";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signIn(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );
      return const Right("Successfully signed in to the account.");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == "invalid-email") {
        message = "User associated with email address does not exist.";
      } else if (e.code == "invalid-credential") {
        message = "Password provided is not correct.";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromMap(user.data()!);
      userModel.imageUrl =
          firebaseAuth.currentUser?.photoURL ?? AppURLs.defaultImage;
      return Right(userModel.toEntity());
    } catch (e) {
      return const Left("An error has occurred, Please try again!");
    }
  }
}
