import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/services/api/check_device_overlap.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:smartfarm/utils/snack_bar.dart';

class ScannerWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ScannerWidget({Key key, this.scaffoldKey}) : super(key: key);
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
      final scanData = Provider.of<ScanData>(context, listen: false);
      scanData.setScan(true);
      scanData.setDeviceUUID(qrCodeResult);
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
                  widget.scaffoldKey.currentState
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      duration: Duration(seconds: 10),
                      content: Row(
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("   기기와 연결 중입니다.")
                        ],
                      ),
                    ));
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
