import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/model/farmer_model/profile_farmer.dart';
import 'package:smartfarm/services/firebase_provider.dart';
import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/screens/devices_connect/forms/crop_edit_widget.dart';
import 'package:smartfarm/screens/devices_connect/forms/scanner_widget.dart';
import 'package:smartfarm/services/api/farmer_profile.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class ConnectPage extends StatefulWidget {
  final uid;

  const ConnectPage({Key key, this.uid}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DateTime backBtnPressedTime;

  fetchProfileFarmer() async {
    ProfileFarmer data =
        await Provider.of<FarmerProfile>(context, listen: false)
            .getProfile(widget.uid);
    Provider.of<FarmerProfile>(context, listen: false).setFarmerProfile(data);
  }

  @override
  void initState() {
    fetchProfileFarmer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Stack(
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
              Consumer<FarmerProfile>(
                builder: (context, farmerData, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      farmerData.isLoading
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Text(
                              '${farmerData.getFarmerProfile().nickName}님' ??
                                  '고객님',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NotoSans-Bold',
                                fontSize: 19.0,
                              ),
                            ),
                      Text(
                        "스마트팜에 오신 것을 환영합니다.",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'NotoSans-Regular',
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoBox() {
    final scanData = Provider.of<ScanData>(context);
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
          child: IndexedStack(
            index: scanData.isScan ? 1 : 0,
            children: <Widget>[
              ScannerWidget(
                scaffoldKey: _scaffoldKey,
              ),
              CropEditWidget(
                scaffoldKey: _scaffoldKey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButton = backBtnPressedTime == null ||
        currentTime.difference(backBtnPressedTime) > Duration(seconds: 3);

    if (backButton) {
      backBtnPressedTime = currentTime;
      Fluttertoast.showToast(
          msg: '한 번 더 클릭하여 앱을 종료해주세요.',
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    return true;
  }
}
