import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class QRcodeForm extends StatefulWidget {
  @override
  _QRcodeFormState createState() => _QRcodeFormState();
}

class _QRcodeFormState extends State<QRcodeForm> {
  var result;

  Future _scanQR() async {
    try {
      final qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult.rawContent;
        print(result);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = 'Camera permission was denied';
        });
      } else {
        setState(() {
          result = 'Unknown Error ${ex}';
        });
      }
    } on FormatException {
      setState(() {
        result = 'you pressed the back button before scanning anything';
      });
    } catch (ex) {
      setState(() {
        result = 'Unknown Error ${ex}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
              'QR코드로 농장 등록',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'NotoSans-Medium',
                color: tutorialFontColor,
              ),
            ),
//            Text(
//              //result,
//            ),
          ],
        ),
      ),
    );
  }
}
