import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/components/sign_in.dart';
import 'package:smartfarm/utils/snack_bar.dart';
import '../constants/smartfarmer_constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _pwTEC = TextEditingController();
  TextEditingController _cpwTEC = TextEditingController();

  @override
  void dispose() {
    _emailTEC.dispose();
    _pwTEC.dispose();
    _cpwTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  login_Gradient1,
                  login_Gradient2,
                  login_Gradient3,
                  login_Gradient4,
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '가입하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: smartfarmer_auth_padding,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: smartfarmer_auth_padding,
                    ),
                    _buildTF(
                        "이메일", "이메일을 입력해주세요", _emailTEC, false, Icons.email),
                    SizedBox(
                      height: smartfarmer_auth_padding,
                    ),
                    _buildTF("비밀번호", "비밀번호를 입력해주세요", _pwTEC, true, Icons.lock),
                    SizedBox(
                      height: smartfarmer_auth_padding,
                    ),
                    _buildTF("비밀번호 확인", "비밀번호 확인", _cpwTEC, true, Icons.lock),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildLoginBtn(),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTF(String using, String hint, TextEditingController formkey,
      bool obscure, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          using,
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            controller: formkey,
            validator: (String value) {
              if (formkey == _emailTEC) {
                // email textformfield
                // ignore: missing_return
                if (value.isEmpty || !value.contains("@")) {
                  //Snackbar(context, "이메일을 작성해주세요");
                  return "이메일을 작성해주세요";
                } else if (value.contains(" ") || value.contains('\t')) {
                  //Snackbar(context, "공백이 포함되어 있습니다");
                  return "공백이 포함되어 있습니다";
                }
                return null;
              } else if (formkey == _pwTEC) {
                //비밀번호 textformfield
                if (value.isEmpty) {
                  //Snackbar(context, "비밀번호를 입력해주세요");
                  return "비밀번호를 입력해주세요";
                } else {
                  return null;
                }
              } else {
                //비밀번호 확인 textformfield
                if (value.isEmpty) {
                  //Snackbar(context, "비밀번호를 입력해주세요");
                  return "비밀번호를 입력해주세요";
                } else if (_pwTEC.text != value) {
                  return "위에서 입력한 비밀번호랑 일치하지 않습니다";
                } else {
                  return null;
                }
              }
            },
            obscureText: obscure,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              hintText: hint,
              hintStyle: kHintTextStyle,
              errorStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _joinApp;
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smartfarmer_auth_padding),
        ),
        color: Colors.white,
        child: Text(
          '가입하기',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        final route = MaterialPageRoute(builder: (context) => SignIn());
        Navigator.pushReplacement(context, route);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '계정이 있으신가요? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: '로그인하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _joinApp async {
    final AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailTEC.text, password: _pwTEC.text);

    final FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser == null) {
      Snackbar(context, "잠시 뒤에 다시 시도해주세요");
    }
  }
}
