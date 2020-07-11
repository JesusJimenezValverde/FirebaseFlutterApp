import 'package:flutter/material.dart'; //todo flutter
import 'package:flutter/cupertino.dart'; //IOSink
import 'package:FirebaseFlutterApp/Services/auth.dart';
import 'package:provider/provider.dart'; 
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    
 
  Widget _signOutButton() {
    final authService = Provider.of<AuthService>(context);
    return InkWell(
      onTap: () {
        authService.signOut(); 
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'SignOut',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
 
  Widget _icon() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Welcome to KEMEDS',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Image.asset(
              'assets/images/kemeds.png',
              width: 300,
              height: 200,
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'K',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 45,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'EM',
              style: TextStyle(color: Colors.black, fontSize: 45),
            ),
            TextSpan(
              text: 'EDS',
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xfffbb448), Color(0xffe46b10)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 100,
              ), 
              _signOutButton(),
              SizedBox(
                height: 50,
              ),
              _icon()
            ],
          ),
        ),
      ),
    );
  }
}