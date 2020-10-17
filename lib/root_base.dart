import 'package:authenticationapp/auth.dart';
import 'package:authenticationapp/loginpage.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'loginpage.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  _RootPageState createState() => new _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(auth: widget.auth);
      case AuthStatus.signedIn:
        return new Container(
          child: Center(
            child: Text(
              "Welcome to the App",
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
          ),
        );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello you are finally here"),
      ),
    );
  }
}
