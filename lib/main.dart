import 'package:FirebaseFlutterApp/Pages/SignUp_Page/signUp.dart';
import 'Pages/WelcomePage/welcome_Page.dart';
import 'Pages/LoginPage/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'Pages/HomePage/home_page.dart';
import 'Services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _AppState createState() {
    return _AppState();
  }
}

class _AppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthService.instance(),
      child: MaterialApp(
          initialRoute: '/',
          routes: {
            // Rutas
          },
          debugShowCheckedModeBanner: false,
          title: 'Firebase Auth con Provider',
          home: Consumer(
            builder: (context, AuthService authService, _) {
              switch (authService.status) {
                case AuthStatus.Uninitialized:
                  return WelcomePage();
                case AuthStatus.Authenticated:
                  return HomePage();
                case AuthStatus.Authenticating:
                  return LogView();
                case AuthStatus.Unauthenticated:
                  return WelcomePage();
                case AuthStatus.Registering:
                  return SignUpPage();
              }
              return null;
            },
          )),
    );
  }
}
