import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthService with ChangeNotifier {
  final FirebaseAuth auth;

  GoogleSignInAccount googleUser;

  AuthStatus status = AuthStatus.Uninitialized;
  final GoogleSignIn googleSignInV = GoogleSignIn(); //sigIn

  AuthService.instance() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  /// This function looks for changes in the status and notify the Listeners
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
      case 'Registering':
        status = AuthStatus.Registering;
        break;
    }
    print(status);
    notifyListeners();
  }

  Future<void> googleSignIn() async {
    try {
      print("ENTRO A SIGN IN");
      GoogleSignInAccount googleUser =
          await googleSignInV.signIn(); //choose account
      print("MURIÓ                                             AQUI");
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print("GOOGLE AUTH: " + googleAuth.idToken);
      this.googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      print("BEFORE");
      await auth.signInWithCredential(credential);
      if (auth.currentUser() != null) {
        status = AuthStatus.Authenticated;
        notifyListeners();
      }
    } catch (e) {
      status = AuthStatus.Uninitialized;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPasswordOwned(
      String email, String password) async {
    try {
      await auth.signInWithCredential(EmailAuthProvider.getCredential(
        email: email,
        password: password,
      ));
      if (auth.currentUser() != null) {
        status = AuthStatus.Authenticated;
        notifyListeners();
      }
    } catch (e) {
      status = AuthStatus.Uninitialized;
      notifyListeners();
    }
  }

  Future<void> signInWithFacebook() async {
    //status = AuthStatus.Authenticating;
    //notifyListeners();
    try {
      FacebookLogin facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);
      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        print('got the Facebook credential');
        await auth.signInWithCredential(credential);
        if (auth.currentUser() != null) {
          status = AuthStatus.Authenticated;
          notifyListeners();
        }
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
