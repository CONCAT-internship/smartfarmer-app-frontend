import 'package:flutter/material.dart';
import 'package:smartfarm/screen/sign_in.dart';
import 'package:smartfarm/screen/sign_up.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Widget currentWidget = SignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          currentWidget,
          _buildSignupBtn(context),
        ],
      ),
    );
  }

  Widget _buildSignupBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 100,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if(currentWidget is SignIn){
              currentWidget = SignUp();
            }else{
              currentWidget = SignIn();
            }
          });
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: (currentWidget is SignIn) ? '계정이 없으신가요? ' : '계정이 있으신가요? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: (currentWidget is SignIn) ? '가입하기' : '로그인하기',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

