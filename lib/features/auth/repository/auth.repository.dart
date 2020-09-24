import 'package:Pruuu/main.dart';
import 'package:Pruuu/models/user.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  Future<bool> get hasUser async => await getUser() != null;

  Future<FirebaseUser> getUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future<User> getUserInfo() async {
    FirebaseUser user = await getUser();
    return User.fromMap(
      await _firestore.collection('users').document(user.uid).get(),
    );
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
  }

  Future<bool> fillUserInfo(
      {String displayName,
      String userName,
      String pictureUrl,
      bool newUser = false}) async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    authStore.userInfo.displayName =
        displayName != null && displayName.isNotEmpty
            ? displayName
            : authStore.userInfo.displayName;
    authStore.userInfo.userName = userName != null && userName.isNotEmpty
        ? userName
        : authStore.userInfo.userName;
    authStore.userInfo.profilePicture =
        pictureUrl != null && pictureUrl.isNotEmpty
            ? pictureUrl
            : authStore.userInfo.profilePicture;

    try {
      await _firestore
          .collection('users')
          .document(user.uid)
          .setData(authStore.userInfo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
