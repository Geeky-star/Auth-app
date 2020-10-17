import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth});
  final BaseAuth auth;
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String user =
              await widget.auth.signInWithEmailAndPassword(_email, _password);

          print("signed: $user");
        } else {
          String user = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);

          print("Registered: $user");
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
            onPressed: moveToRegister, child: Text("Create an Acount"))
      ];
    } else {
      return [
        new RaisedButton(
          child: Text(
            "Create an account",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: Text("Have an account? Login"),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
