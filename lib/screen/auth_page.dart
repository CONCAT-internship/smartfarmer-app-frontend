import 'package:flutter/material.dart';
import 'package:smartfarm/components/sign_in.dart';
import 'package:smartfarm/components/sign_up.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SignIn(),
        ],
      ),
    );
  }
}
