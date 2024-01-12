import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pruuu/main_store.dart';
import 'package:pruuu/model/user_model.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final authViewModel = MainStore().authViewModel;

  Future<bool> get hasUser async => await getUser() != null;

  Future<User?> getUser() async {
    return await _firebaseAuth.currentUser;
  }

  Future<UserModel> getUserInfo() async {
    User? user = await getUser();
    final result = await _firestore.collection('users').doc(user?.uid).get();
    return UserModel.fromMap(result);
  }

  Future<UserCredential> signIn(
    String email,
    String password,
  ) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult;
  }

  Future<UserCredential> signUp(String email, String password) async {
    var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> fillUserInfo({
    String displayName = '',
    String userName = '',
    String pictureUrl = '',
    bool newUser = false,
  }) async {
    final user = await _firebaseAuth.currentUser;

    authViewModel.userInfo.displayName = displayName.isNotEmpty
        ? displayName
        : authViewModel.userInfo.displayName;
    authViewModel.userInfo.userName =
        userName.isNotEmpty ? userName : authViewModel.userInfo.userName;
    authViewModel.userInfo.profilePicture = pictureUrl.isNotEmpty
        ? pictureUrl
        : authViewModel.userInfo.profilePicture;

    try {
      await _firestore
          .collection('users')
          .doc(user!.uid)
          .set(authViewModel.userInfo.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
