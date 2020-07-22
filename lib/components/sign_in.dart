import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/components/sign_up.dart';
import 'package:smartfarm/utils/snack_bar.dart';

import '../constants/smartfarmer_constants.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _pwTEC = TextEditingController();

  @override
  void dispose() {
    _emailTEC.dispose();
    _pwTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: true,
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
                      '로그인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30,),
                    _buildTF("이메일", "이메일을 입력해주세요", _emailTEC, false, Icons.email),
                    SizedBox(height: 30.0,),
                    _buildTF("비밀번호", "비밀번호를 입력해주세요", _pwTEC, true, Icons.lock),
                    _buildForgotPasswordBtn(),
                    _buildLoginBtn(),
                    _buildSignInWithText(),
                    _buildSocialBtnRow(),
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

  Widget _buildTF(String using, String hint, TextEditingController formkey, bool obscure, IconData icon) {
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
            validator: (String value){
              if(formkey == _emailTEC){ // email textformfield
                // ignore: missing_return
                if(value.isEmpty || !value.contains("@")){
                  //Snackbar(context, "이메일을 작성해주세요");
                  return "이메일을 작성해주세요";
                }else if (value.contains(" ") || value.contains('\t')){
                  //Snackbar(context, "공백이 포함되어 있습니다");
                  return "공백이 포함되어 있습니다";
                }
                return null;
              }else{ //비밀번호 textformfield
                if(value.isEmpty){
                  //Snackbar(context, "비밀번호를 입력해주세요");

                  return "비밀번호를 입력해주세요";
                }else{
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
  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '비밀번호 찾기',
          style: kLabelStyle,
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){
          if(_formKey.currentState.validate()){
            _loginApp;
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          '로그인',
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
  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- 또는 -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }
  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              facebook,
            ),
          ),
          _buildSocialBtn(
            () => print('Login with KaKao'),
            AssetImage(
              kakaotalk,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        final route = MaterialPageRoute(builder: (context) => SignUp());
        Navigator.pushReplacement(context, route);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '계정이 없으신가요? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: '가입하기',
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

  get _loginApp async{
    final AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
        email: _emailTEC.text, password: _pwTEC.text);

    final FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser == null) {
      Snackbar(context, "잠시 뒤에 다시 시도해주세요");
    }
  }
}
