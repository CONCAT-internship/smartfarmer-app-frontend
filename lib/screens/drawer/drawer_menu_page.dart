import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/screens/auth/auth_page.dart';
import 'package:smartfarm/services/firebase_provider.dart';

import 'package:smartfarm/services/scan_data.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:http/http.dart' as http;

class DrawerMenuPage extends StatefulWidget {
  @override
  _DrawerMenuPageState createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  bool toggleValue;

  void setFan() async {
    String url = '$API/Control?uuid=756e6b776f000c04';
    //String url = '$API/Control?uuid=$deviceUUID';
    final http.Response response = await http.post(
      url,
      body: jsonEncode({
        "uuid": "756e6b776f000c04",
        "status": {"led": false, "fan": toggleValue}
      }),
      headers: {'Content-Type': "application/json"},
    );

    if (response.statusCode == 200) {
      print(toggleValue);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    final isFan = Provider.of<ScanData>(context, listen: false).isFan;
    toggleValue = isFan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  title: Text(
                    '슈퍼파머스',
                    style: TextStyle(
                      color: infoBoxTextColor,
                      fontFamily: 'NotoSans-Bold',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                ListTile(
                  title: InkWell(
                      onTap: () {
                        Provider.of<FirebaseProvider>(context, listen: false)
                            .signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => AuthPage()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text("로그아웃")),
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Text("FAN"),
                      Spacer(),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: 40,
                        width: 100.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100].withOpacity(0.5),
                        ),
                        child: Stack(
                          children: <Widget>[
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                              top: 3.0,
                              left: toggleValue ? 60.0 : 0.0,
                              right: toggleValue ? 0.0 : 60.0,
                              child: InkWell(
                                onTap: toggleButton,
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 200),
                                  transitionBuilder: (Widget child,
                                      Animation<double> animation) {
                                    return RotationTransition(
                                      child: child,
                                      turns: animation,
                                    );
                                  },
                                  child: toggleValue
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        )
                                      : Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.red,
                                          size: 35.0,
                                          key: UniqueKey(),
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
      setFan();
    });
  }
}
