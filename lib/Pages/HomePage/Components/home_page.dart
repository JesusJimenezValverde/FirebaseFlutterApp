import 'package:flutter/material.dart'; //todo flutter
import 'package:flutter/cupertino.dart'; //IOSink
import 'package:FirebaseFlutterApp/Services/auth.dart';
import 'package:provider/provider.dart';

import 'home_login_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: HomeLoginPage("Hey", false),
    );
  }
}
