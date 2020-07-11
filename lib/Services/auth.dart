import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth auth;

  GoogleSignInAccount googleUser;

  AuthStatus status = AuthStatus.Uninitialized;

  final GoogleSignIn googleSignInV = GoogleSignIn(); //sigIn

  AuthService.instance() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  /// This function chage the status
  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      status = AuthStatus.Unauthenticated;
    } else {
      status = AuthStatus.Authenticated;
    }
    notifyListeners();
  }

  Future<void> changeStatus(String state) {
    switch (state) {
      case 'Unauthenticated':
        status = AuthStatus.Unauthenticated;
        break;
      case 'Uninitialized':
        status = AuthStatus.Uninitialized;
        break;
      case 'Authenticated':
        status = AuthStatus.Authenticated;
        break;
      case 'Authenticating':
        status = AuthStatus.Authenticating;
        break;
    }
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      GoogleSignInAccount googleUser =
          await googleSignInV.signIn(); //choose account
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      this.googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      await auth.signInWithCredential(credential);
      //FirebaseUser userAuth = authResult.user;
    } catch (e) {
      status = AuthStatus.Uninitialized;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPasswordOwned(
      String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      await auth.signInWithCredential(EmailAuthProvider.getCredential(
        email: email,
        password: password,
      ));
    } catch (e) {
      print("Account does not exist");
      status = AuthStatus.Unauthenticated;
      notifyListeners();
    }
  }

  Future<void> signInWithFacebook() async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      FacebookLogin facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        await auth.signInWithCredential(
          FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token),
        );
      }
    } catch (e) {
      status = AuthStatus.Uninitialized;
      notifyListeners();
    }
  }

  void signOut() {
    if (googleUser != null) {
      googleUser.clearAuthCache();
    }
    googleSignInV.signOut();
    auth.signOut();
    status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get statusAuth => status;
  GoogleSignInAccount get googleUserSA => googleUser;
}
