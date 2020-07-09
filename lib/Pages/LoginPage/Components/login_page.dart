import 'package:flutter/material.dart'; //todo flutter
import 'package:flutter/cupertino.dart'; //IOSink
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
      appBar: AppBar(title: Text("SignIn")),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.lightGreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.lightBlueAccent[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text("SignIn"),
                    onPressed: () async{
                      await authService.googleSignIn();
                    },
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
 