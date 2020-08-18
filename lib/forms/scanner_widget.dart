import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/scan_data.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;

class ScannerWidget extends StatefulWidget {
  @override
  _ScannerWidgetState createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  var result; //QR코드 결과
  bool isScan = false;

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
      isScan = true;

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
        result = qrResult.rawContent;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanData = Provider.of<ScanData>(context);
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
                  if(isScan){
                    scanData.isScan = true;
                    scanData.deviceUUID = result;
                  }
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
