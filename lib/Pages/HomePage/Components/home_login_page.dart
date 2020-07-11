import 'package:FirebaseFlutterApp/Components/Buttons/sign_In_Button.dart';
import 'package:flutter/material.dart';
import 'package:FirebaseFlutterApp/Services/auth.dart';
import 'package:provider/provider.dart';

class HomeLoginPage extends StatelessWidget {
  const HomeLoginPage._({Key key, this.isLoading, this.title})
      : super(key: key);
  final String title;
  final bool isLoading;

  HomeLoginPage(this.title, this.isLoading);

  static const Key googleButtonKey = Key('google');
  static const Key facebookButtonKey = Key('facebook');
  static const Key emailPasswordButtonKey = Key('email-password');

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 32.0),
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ),
            SizedBox(height: 32.0),
            SocialSignInButton(
              key: googleButtonKey,
              assetName: 'assets/go-logo.png',
              text: 'signInWithGoogle',
              onPressed: isLoading
                  ? null
                  : () async {
                      await authService.googleSignIn();
                    },
              color: Colors.white,
            ),
            SizedBox(height: 8),
            SocialSignInButton(
              key: facebookButtonKey,
              assetName: 'assets/fb-logo.png',
              text: 'SignIn With Facebook',
              textColor: Colors.white,
              onPressed: isLoading ? null : () => "", //,
              color: Color(0xFF334D92),
            ),
            SizedBox(height: 8),
            SignInButton(
              key: emailPasswordButtonKey,
              text: 'Email & Password',
              onPressed: isLoading
                  ? null
                  : () async {
                      await authService.signInWithEmailAndPasswordOwned(
                          'danny@danny.com', '123456');
                    },
              textColor: Colors.white,
              color: Colors.teal[700],
            ),
          ],
        ),
      ),
    );
  }
}
