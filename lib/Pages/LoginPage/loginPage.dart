import 'package:FirebaseFlutterApp/Components/Buttons/sign_In_Button.dart';
import 'package:FirebaseFlutterApp/Services/auth.dart';
import '../../Components/Widgets/bezier_Container.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LogView extends StatefulWidget {
  LogView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LogViewState createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  TextEditingController loginController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  Widget _backButton() {
    final authService = Provider.of<AuthService>(context);

    return InkWell(
      onTap: () {
        authService.changeStatus('Uninitialized');
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 0,
                top: 10,
                bottom: 10,
              ),
              child: Icon(
                Icons.keyboard_arrow_left,
                color: Colors.black,
              ),
            ),
            Text(
              'Back',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 55),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _divider(),
                  _socialLogin(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: _backButton(),
          ),
        ],
      ),
    ));
  }

  Widget _submitButton() {
    final authService = Provider.of<AuthService>(context);
    bool isLoading = false;
    return RaisedButton(
      onPressed: isLoading
          ? null
          : () async {
              print(loginController.text);
              print(passController.text);
              await authService.signInWithEmailAndPasswordOwned(
                loginController.text,
                passController.text,
              );
            },
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xfffbb448),
              Color(0xfff7892b),
            ],
          ),
        ),
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _socialLogin() {
    const Key googleButtonKey = Key('google');
    const Key facebookButtonKey = Key('facebook');
    const bool isLoading = false;

    final authService = Provider.of<AuthService>(context);

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50.0),
          SocialSignInButton(
            key: googleButtonKey,
            assetName: 'assets/go-logo.png',
            text: 'SignIn With Google',
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
            onPressed:
                isLoading ? null : () => authService.signInWithFacebook(),
            color: Color(0xFF334D92),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    final authService = Provider.of<AuthService>(context);
    return InkWell(
      onTap: () {
        authService.changeStatus('Registering');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                color: Color(0xfff79c4f),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'W',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ell',
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
              ),
            ),
            TextSpan(
              text: 'come',
              style: TextStyle(
                color: Color(0xffe46b10),
                fontSize: 40,
              ),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        Text(
          "Enter Email & Password",
          style: TextStyle(fontSize: 17),
        ),
        TextField(
          controller: loginController,
          decoration: InputDecoration(
            hintText: 'Email',
          ),
        ),
        TextField(
            controller: passController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
            )),
      ],
    );
  }
}
