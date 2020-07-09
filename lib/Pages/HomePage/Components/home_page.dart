import 'package:flutter/material.dart'; //todo flutter
import 'package:flutter/cupertino.dart'; //IOSink
import 'package:FirebaseFlutterApp/Services/auth.dart'; 
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  HomePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> { 
 
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
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
                    child: Text("SignOut"),
                    onPressed: () {
                      authService.signOut();
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
 