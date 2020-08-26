import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:smartfarm/services/check_device_overlap.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:smartfarm/utils/snack_bar.dart';

class ScannerWidget extends StatefulWidget {
  @override
  _ScannerWidgetState createState() => _ScannerWidgetState();
}

class _ScannerWidgetState extends State<ScannerWidget> {
  var qrCodeResult; //QR코드 결과

  Future _scanQR() async {
    final qrResult = await BarcodeScanner.scan();
    qrCodeResult = qrResult.rawContent;

    final result = await checkDevice
        .checkDevice(qrCodeResult); // 스마트팜 기기 체크 CheckDeviceOverlap

    if(result.error){
      alertSnackbar(context, result.errorMessage);
    }else{
      print('QR코드 스캔 성공~!');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  _scanQR(); // QR CODE 스캐너 실행
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
