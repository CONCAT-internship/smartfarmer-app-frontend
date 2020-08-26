import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/animation/fade_animation.dart';
import 'package:smartfarm/firebase/auth_exception_handler.dart';
import 'package:smartfarm/firebase/auth_result_status.dart';
import 'package:smartfarm/services/firebase_provider.dart';

class ForgetPage extends StatefulWidget {
  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  TextEditingController _mailCon = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  @override
  void dispose() {
    _mailCon.dispose();
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
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        FadeAnimation(
                          1,
                          Text(
                            "비밀번호 찾기",
                            style: TextStyle(
                              fontFamily: 'NotoSans-Bold',
                              fontSize: 32.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          1.2,
                          Text(
                            "가입했던 이메일을 입력해주세요",
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
                          FadeAnimation(
                            1.2,
                            makeInput(
                                label: '이메일', editingController: _mailCon),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: FadeAnimation(
                        1.4,
                        Container(
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
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _findPassword();
                            },
                            color: Colors.purpleAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              '전송',
                              style: TextStyle(
                                fontFamily: 'NotoSans-Medium',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
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

  _findPassword() async {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("   이메일 전송중입니다...")
          ],
        ),
      ));

    final result = await fp.sendPasswordResetEmail(_mailCon.text);
    print('result 상태 $result');
    _scaffoldKey.currentState.hideCurrentSnackBar();
    if (result == AuthResultStatus.successful) {
      _mailCon.text = '';
      showMessage('메일을 전송했습니다. 이메일을 확인해주세요.');
    } else {
      final errorMsg = AuthExceptionHandler.generateExceptionMessage(result);
      showLastFBMessage(errorMsg);
      _mailCon.text = '';
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

  showMessage(String msg) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        duration: Duration(seconds: 10),
        content: Text(msg),
        action: SnackBarAction(
          label: "Done",
          onPressed: () {},
        ),
      ));
  }
}

Widget makeInput(
    {label, obscureText = false, TextEditingController editingController}) {
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
