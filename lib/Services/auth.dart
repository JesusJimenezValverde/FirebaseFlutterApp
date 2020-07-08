import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/user.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus{
  Uninitialized,  
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth auth; 
  GoogleSignInAccount googleUser;
  User user = new User();

  final Firestore db = Firestore.instance;   ///db
  AuthStatus status = AuthStatus.Uninitialized;  ///status

  final GoogleSignIn googleSignInV = GoogleSignIn();  //sigIn

  AuthService.instance() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(_onAuthStateChanged);  /// listen the state of the status
  }
  
/// This function chage the status
  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap = await db
        .collection('users')
        .document(firebaseUser.uid)
        .get();

      user.setFromFireStore(userSnap);
      status = AuthStatus.Authenticated;
    }

    notifyListeners();
  }

  Future<FirebaseUser> googleSignIn() async {
    status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      GoogleSignInAccount googleUser = await googleSignInV.signIn();  //choose account
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      this.googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider
        .getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      AuthResult authResult = await auth.signInWithCredential(credential);
      FirebaseUser userAuth = authResult.user;
      await updateUserData(userAuth);
    } catch (e) {
      status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }


/// Update data in the db
  Future<DocumentSnapshot> updateUserData(FirebaseUser userAuth) async {
    DocumentReference userRef = db
      .collection('users')
      .document(userAuth.uid);

    userRef.setData({
      'uid': userAuth.uid,
      'email': userAuth.email,
      'lastSign': DateTime.now(),
      'photoURL': userAuth.photoUrl,
      'displayName': userAuth.displayName,
    }, merge: true);

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  void signOut() {
    auth.signOut();
    status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get statusAuth => status;
  User get userA => user;
  GoogleSignInAccount get googleUserSA => googleUser;

}