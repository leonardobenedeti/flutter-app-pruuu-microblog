import 'dart:io';

import 'package:Pruuu/features/auth/repository/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _localStorage = new LocalStorage();
  // final _pictureRepository = new PictureRepository();

  Future<bool> get hasUser async => await getUser() != null;

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<AuthResult> signIn(
    String email,
    String password,
  ) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult;
  }

  Future<AuthResult> signUp(String email, String password) async {
    var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
    await _localStorage.deleteStorage("user");
  }

  Future<bool> fillUserInfo(String displayName, {File picture}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    // final picturePath = await _pictureRepository.pathPicture(user.uid);

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = displayName;
    // userUpdateInfo.photoUrl = picturePath;
    try {
      await user.updateProfile(userUpdateInfo);
      return true;
    } catch (e) {
      return false;
    }
  }
}
