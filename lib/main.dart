import 'package:flutter/material.dart';
import 'Pages/HomePage/home_page.dart';
import 'Pages/LoginPage/Components/login_page.dart';
import 'Services/auth.dart';
import 'package:provider/provider.dart';

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
                  return Text('Cargando');
                case AuthStatus.Authenticated:
                  return HomePage();
                case AuthStatus.Authenticating:
                  return SignIn();
                case AuthStatus.Unauthenticated:
                  return SignIn();
              }
              return null;
            },
          )),
    );
  }
}
