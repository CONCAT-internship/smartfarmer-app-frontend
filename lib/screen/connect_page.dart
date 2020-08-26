import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/model/profile_farmer.dart';
import 'package:smartfarm/provider/firebase_provider.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/provider/scan_data.dart';
import 'package:smartfarm/forms/crop_edit_widget.dart';
import 'package:smartfarm/forms/scanner_widget.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  Future<ProfileFarmer> getProfile() async {
    try {
      String url = '$API/ProfileFarmer?uid=Xecm2PHp7QNfCmb0MQOFdJdy5af2';
      final http.Response response = await http.get(url);
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      final ProfileFarmer profileFarmer = ProfileFarmer.fromJson(responseData);
      return profileFarmer;
    } catch (err) {
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    FutureBuilder(
                      future: getProfile(),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          final farmerProfile = snapshot.data;
                          return Text(
                            farmerProfile.nickName,
                            // '김태훈님',
                            //farmerData.data.nickName,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NotoSans-Bold',
                              fontSize: 19.0,
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },

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
              ScannerWidget(),
              CropEditWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
