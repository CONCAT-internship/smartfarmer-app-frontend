import 'package:flutter/material.dart';
import 'package:smartfarm/animation/fade_animation.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 100,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text(
                      "가입하기",
                      style: TextStyle(
                        fontFamily: 'NotoSans-Bold',
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(1.2, Text(
                      "스마트팜 세계에 오신 것을 환영합니다",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontFamily: 'NotoSans-Regular',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(1.2, makeInput(label: '이메일')),
                  FadeAnimation(1.3, makeInput(label: '닉네임')),
                  FadeAnimation(1.4, makeInput(label: '비밀번호', obscureText: true)),
                  FadeAnimation(1.5, makeInput(label: '비밀번호 확인', obscureText: true)),
                ],
              ),
              Column(
                children: <Widget>[
                  FadeAnimation(1.6, Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {},
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          '가입하기',
                          style: TextStyle(
                            fontFamily: 'NotoSans-Medium',
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FadeAnimation(1.7, Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "계정이 있으신가요? ",
                      style: TextStyle(fontFamily: 'Notosans-Regular'),
                    ),
                    Text(
                      "로그인하기",
                      style: TextStyle(
                        fontFamily: 'Notosans-Bold',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget makeInput({label, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15.0,
          fontFamily: 'NotoSans-Regular',
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ],
  );
}
