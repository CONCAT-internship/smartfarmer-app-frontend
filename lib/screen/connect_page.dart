import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/firebase_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_scan/barcode_scan.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  int currentPage = 0;
  var result; //QR코드 결과

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        fontSize: 16.0,
        textColor: Colors.white,
        backgroundColor: Colors.grey[400],
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.BOTTOM);
  }

  void _createPost(String uuid) async {
    final response = await http.post(
      '$API/CheckDeviceOverlap',
      body: jsonEncode(
        {
          'uuid': '$uuid',
        },
      ),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      // 등록 가능한 uuid
      _pageController.jumpToPage(1);
    } else if (response.statusCode == 403) {
      // 이미 존재하는 uuid
      showToast('사용중인 기기입니다.');
    } else if (response.statusCode == 404) {
      showToast('등록되어있지 않은 기기입니다.');
    } else {
      showToast('알 수 없는 에러입니다. 잠시 뒤 시도해주세요.');
    }
  }

  Future _scanQR() async {
    try {
      final qrResult = await BarcodeScanner.scan();
      setState(() {
        _createPost(qrResult.rawContent);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = 'Camera permission was denied';
        });
      } else {
        setState(() {
          result = 'Unknown Error $ex';
        });
      }
    } on FormatException {
      setState(() {
        result = 'you pressed the back button before scanning anything';
      });
    } catch (ex) {
      setState(() {
        result = 'Unknown Error $ex';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.8,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  infoGradient1,
                  infoGradient2,
                ],
                stops: [0.1, 0.5],
              ),
            ),
          ),
          Container(
            height: double.infinity,
//            foregroundDecoration: BoxDecoration(
//              color: Colors.grey,
//              backgroundBlendMode: BlendMode.darken,
//            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.066,
                ),
                _headerContents(size), // HEAD
                SizedBox(
                  height: 30,
                ),
                infoBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerContents(Size size) {
    return Container(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 10.0,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "슈퍼파머스",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'NotoSans-Bold',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.notifications_none),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {
                    Provider.of<FirebaseProvider>(context, listen: false)
                        .signOut();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.menu),
                  iconSize: 25,
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/ogu.png'),
                  radius: 25.0,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "김태훈님",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans-Bold',
                        fontSize: 19.0,
                      ),
                    ),
                    Text(
                      "당신의 농장은 잘 관리되고 있습니다.",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'NotoSans-Regular',
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget infoBox() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
            ),
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15.0,
              ),
            ],
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (selectedPage) {
              currentPage = selectedPage;
            },
            children: <Widget>[
              scannerQR(),
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Image.asset(
                                  farmName,
                                  width: 80,
                                  height: 80,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 110),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: fieldLineColor, width: 2.5),
                                      ),
                                      hintText: '농장 이름을 입력해주세요',
                                      hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'NotoSans-Medium',
                                        color: tutorialFontColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    makeInput(label: '작물'),
                                    limitInput(prop: '온도'),
                                    limitInput(prop: '습도'),
                                    limitInput(prop: 'pH  '),
                                    limitInput(prop: 'EC   '),
                                    makeInputDuo(prop: '수온', prop2: '수위'),
                                    makeInputDuo(prop: '조도', prop2: '일조'),
                                    Text(
                                      '재식 거리',
                                      style: connectFont,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        makeShortInput(),
                                        Text(' X '),
                                        makeShortInput(),
                                        Text('    ~    '),
                                        makeShortInput(),
                                        Text(' X '),
                                        makeShortInput(),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInputDuo({prop, prop2}) {
    return Row(
      children: <Widget>[
        makeInput(label: prop),
        SizedBox(
          width: 23,
        ),
        makeInput(label: prop2),
      ],
    );
  }

  Widget limitInput({prop}) {
    return Row(
      children: <Widget>[
        makeInput(label: prop),
        Text('     ~     '),
        makeInput(label: ''),
      ],
    );
  }

  Widget makeShortInput() {
    return Container(
      width: 58,
      height: 30,
      child: TextField(
        decoration: InputDecoration(
          suffixText: "dd",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              label,
              style: connectFont,
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 100,
              height: 30,
              child: TextField(
                decoration: InputDecoration(
                  suffixText: "dd",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget scannerQR() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  _scanQR();
                },
                child: Image.asset(
                  qrCodeImg,
                  width: 80,
                  height: 80,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                //Provider.of<FirebaseProvider>(context).getUser().uid,
                //Provider.of<MineFarmerData>(context).data.email,
                'QR코드로 농장 등록',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'NotoSans-Medium',
                  color: tutorialFontColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
