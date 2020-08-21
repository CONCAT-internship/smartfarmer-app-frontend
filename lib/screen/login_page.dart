import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/animation/fade_animation.dart';
import 'package:smartfarm/firebase/auth_exception_handler.dart';
import 'package:smartfarm/firebase/auth_result_status.dart';
import 'package:smartfarm/provider/firebase_provider.dart';
import 'package:smartfarm/screen/forget_page.dart';
import 'package:smartfarm/screen/signup_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _mailCon = TextEditingController();
  TextEditingController _pwCon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
    _pwCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
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
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeAnimation(1, Text(
                            "로그인",
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
                            "이메일과 비밀번호를 입력해주세요",
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: <Widget>[
                          FadeAnimation(1.2, makeInput(label: '이메일', editingController: _mailCon),),
                          SizedBox(
                            height: 30,
                          ),
                          FadeAnimation(1.3, makeInput(label: '비밀번호', obscureText: true, editingController: _pwCon)),
                          SizedBox(
                            height: 6,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPage()));
                              },
                              child: FadeAnimation(1.3, Text("비밀번호 찾기", style: TextStyle(
                                  fontFamily: 'NotoSans-Medium'
                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: FadeAnimation(1.4, Container(
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
                              _logIn();
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '로그인',
                              style: TextStyle(
                                fontFamily: 'NotoSans-Medium',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeAnimation(1.5, Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "계정이 없으신가요? ",
                            style: TextStyle(fontFamily: 'Notosans-Regular'),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                            },
                            child: Text(
                              "가입하기",
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
              FadeAnimation(1.2, Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(farmerWomen),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _logIn() async{
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   로그인 중입니다...")
          ],
        ),
      ));
    final result = await fp.signInWithEmail(_mailCon.text, _pwCon.text);
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == AuthResultStatus.successful){
      Navigator.pop(context);
    }else{
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(result);
      showLastFBMessage(errorMsg);
      _pwCon.text = '';
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
          label: "Done",
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
      TextField(
        controller: editingController,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: obscureText ? '비밀번호를 입력해주세요' : '이메일을 입력해주세요',
          hintStyle: TextStyle(
            fontFamily: 'NotoSans-Regular',
            fontSize: 13,
          ),
          prefixIcon: obscureText ? Icon(Icons.lock) : Icon(Icons.mail),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[400]),
          ),
        ),
      ),
    ],
  );
}