import 'package:flutter/material.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
class QRcodeForm extends StatelessWidget {
  final deviceId;

  const QRcodeForm({Key key, this.deviceId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 160),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => QrPage()));
              },
              child: Image.asset(
                qrCodeImg,
                width: 80,
                height: 80,
              ),
            ),
            Text(
              'QR코드로 농장 등록',
              style: TextStyle(
                fontSize: 15.0,
                fontFamily: 'NotoSans-Medium',
                color: tutorialFontColor,
              ),
            ),
            Text(
              '$deviceId',
            ),
          ],
        ),
      ),
    );
  }
}

class QrPage extends StatefulWidget {
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Colors.red,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
              onQRViewCreated: _onQRViewCreate,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text('Scan result: $qrText'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
        Navigator.pop(context, MaterialPageRoute(builder: (context) => QRcodeForm(deviceId: qrText,)));
      });
    });
  }
}
