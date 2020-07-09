import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FirebaseFlutterApp/Services/auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Inicia con Google'),
          onPressed: () async {
            await authService.googleSignIn();
          },
        ),
      ),
    );
  }
}
