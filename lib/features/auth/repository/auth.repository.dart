import 'package:Pruuu/features/auth/repository/local_storage.dart';
import 'package:Pruuu/features/auth/repository/picture.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _localStorage = new LocalStorage();
  final _pictureRepository = new PictureRepository();

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

  Future<bool> signUp(String email, String password) async {
    var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult != null;
  }

  void signOut(BuildContext contextoBloc) async {
    await _firebaseAuth.signOut();
    await _localStorage.deleteStorage("user");
  }

  void fillUserInfo(String uid, String displayName) async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    final picturePath = await _pictureRepository.pathPicture(user.uid);

    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = "@leonardobenedeti";
    userUpdateInfo.photoUrl = picturePath;
    await user.updateProfile(userUpdateInfo);
  }
}
