import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/Home_Page/home_Page.dart';
import 'Pages/SignIn_Page/signIn_Page.dart';
import 'Services/auth.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
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
                  return Home();
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

/*
Your keystore contains 1 entry

Alias name: androiddebugkey
Creation date: Jun 17, 2020
Entry type: PrivateKeyEntry
Certificate chain length: 1
Certificate[1]:
Owner: C=US, O=Android, CN=Android Debug
Issuer: C=US, O=Android, CN=Android Debug
Serial number: 1
Valid from: Wed Jun 17 22:43:33 CST 2020 until: Fri Jun 10 22:43:33 CST 2050
Certificate fingerprints:
         SHA1: A2:D3:F7:F8:97:7D:51:94:B5:37:6D:3B:5A:43:48:A2:CB:C7:89:FF
         SHA256: D0:6A:18:E8:7E:FB:52:13:78:8F:DF:90:77:F3:1E:47:DA:ED:6C:F2:F7:3C:EE:24:79:54:78:35:05:24:12:51
Signature algorithm name: SHA1withRSA
Subject Public Key Algorithm: 2048-bit RSA key
Version: 1
*/
