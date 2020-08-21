import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/animation/fade_animation.dart';
import 'package:smartfarm/firebase/auth_exception_handler.dart';
import 'package:smartfarm/firebase/auth_result_status.dart';
import 'package:smartfarm/provider/database_provider.dart';
import 'package:smartfarm/provider/firebase_provider.dart';
import 'package:smartfarm/screen/login_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _nickCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  TextEditingController _cpwCon = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
    _nickCon.dispose();
    _pwCon.dispose();
    _cpwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (fp == null) {
      fp = Provider.of<FirebaseProvider>(context);
    }

    return Scaffold(
      key: _scaffoldKey,
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
          height: MediaQuery.of(context).size.height,
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
                  FadeAnimation(1.2, makeInput(label: '이메일', editingController: _mailCon)),
                  FadeAnimation(1.3, makeInput(label: '닉네임', editingController: _nickCon)),
                  FadeAnimation(1.4, makeInput(label: '비밀번호', obscureText: true, editingController: _pwCon)),
                  FadeAnimation(1.5, makeInput(label: '비밀번호 확인', obscureText: true, editingController: _cpwCon)),
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
                        onPressed: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _signUp();
                        },
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
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "로그인하기",
                        style: TextStyle(
                          fontFamily: 'Notosans-Bold',
                        ),
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

  _signUp() async{
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   가입 중입니다...")
          ],
        ),
      ));
    final result = await fp.signUpWithEmail(_mailCon.text, _pwCon.text, _nickCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == AuthResultStatus.successful) {
      Navigator.pop(context);
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(result);
      showLastFBMessage(errorMsg);
    }
  }

  showLastFBMessage(String error) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        backgroundColor: Colors.red[400],
        duration: Duration(seconds: 10),
        content: Text(error),
        action: SnackBarAction(
          label: "확인",
          textColor: Colors.white,
          onPressed: () {},
        ),
      ));
  }
}

Widget makeInput({label, obscureText = false, TextEditingController editingController}) {
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
      TextFormField(
        maxLines: 1,
        controller: editingController,
        obscureText: obscureText,
//        validator: (String value){
//          if(label == '비밀번호 확인'){
//
//          }
//        },
        decoration: InputDecoration(
          hintText: label == '이메일' ? '이메일을 입력해주세요' : label == '닉네임' ? '닉네임을 입력해주세요' : '비밀번호를 입력해주세요',
          hintStyle: TextStyle(
            fontFamily: 'NotoSans-Regular',
            fontSize: 13,
          ),
          prefixIcon: label == '이메일' ? Icon(Icons.mail) : label == '닉네임' ? Icon(Icons.account_circle) : Icon(Icons.lock),
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
