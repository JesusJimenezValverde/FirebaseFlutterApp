import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:FirebaseFlutterApp/Services/auth.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return SignInState();
  }
}

class SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orangeAccent[400],
        title: Text(
          "SignIn Page",
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.orangeAccent[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.lightBlueAccent[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: 210.0,
                    child: RaisedButton(
                      color: Colors.greenAccent[400],
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Text("Email & Password"),
                      onPressed: () async {
                        await authService.signInWithEmailAndPasswordOwned(
                            'esteban@esteban.com', '123456');
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 230.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      color: Colors.grey[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset('assets/go-logo.png'),
                          Text(
                            'Sign In With Google',
                            style: TextStyle(
                                color: Colors.grey[700], fontSize: 16.0),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        authService.googleSignIn();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 250.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      color: Colors.blue[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset('assets/fb-logo.png'),
                          Text(
                            'Sign In With Facebook',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17.0),
                          ),
                        ],
                      ),
                      onPressed: () async {
                        authService.signInWithFacebook();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
keytool -exportcert -alias androiddebugkey -keystore "C:\Users\Personal\.android\debug.keystore" | "C:\OpenSSL\bin\openssl.exe" sha1 -binary | "C:\OpenSSL\bin\openssl" base64
Enter keystore password:  1234
ga0RGNYHvNM5d0SLGQfpQWAPGJ8=
*/
