import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/firebase_provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/screen/farm_list_page.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;

class QRcodeForm extends StatefulWidget {
  @override
  _QRcodeFormState createState() => _QRcodeFormState();
}

class _QRcodeFormState extends State<QRcodeForm> {
  bool uuidChecking = false;
  var result;

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
      setState(() {
        uuidChecking = true;
      });
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
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: !uuidChecking
            ? Center(
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
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //            Text(
                    //              '농장 이름을 입력해주세요.',
                    //              style: TextStyle(
                    //                fontSize: 15.0,
                    //                fontFamily: 'NotoSans-Medium',
                    //                color: tutorialFontColor,
                    //              ),
                    //            ),

                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        Image.asset(
                          farmName,
                          width: 80,
                          height: 80,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 110),
                          child: TextField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
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

                    MaterialButton(
                      minWidth: 160,
                      height: 55,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FarmListPage()));
                      },
                      color: infoBoxHumidityColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        '확인',
                        style: TextStyle(
                          fontFamily: 'NotoSans-Medium',
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

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
}
