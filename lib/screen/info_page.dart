
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smartfarm/forms/dashboard_widget.dart';

import 'package:smartfarm/shared/smartfarmer_constants.dart';


class InfoPage extends StatefulWidget {
  String sensorUUID;

  InfoPage({Key key, this.sensorUUID}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();
  bool autoValidate = false;
  int selectedStack = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _drawerKey,
      endDrawer: Drawer(
          child: SafeArea(
              child: ListView(padding: EdgeInsets.zero, children: <Widget>[]))),
      //backgroundColor: backgroundColor,
      bottomNavigationBar: _buildBottomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFloatingActionButton(context),
      body: Stack(
        children: <Widget>[
          _headerGradient(size), // HEAD 그라디언트 색상
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

  BottomAppBar _buildBottomAppBar() {
    return BottomAppBar(
      color: backgroundColor,
      //notchMargin: 12.0,
      child: Container(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  _drawerKey.currentState.openEndDrawer();
                },
                color: infoButtonColor,
                iconSize: 32.0,
                //size: 32.0,
              ),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  //databaseProvider.recv();
                },
                color: Colors.grey,
                iconSize: 32.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: infoButtonColor,
      child: Icon(Icons.add),
      onPressed: () {
      },
    );
  }

  Container _headerGradient(Size size) {
    return Container(
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
    );
  }

  Container _headerContents(Size size) {
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
                  onPressed: () {},
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
                        fontFamily: 'NotoSans-Thin',
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

  Expanded infoBox() {
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
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
            child: DashBoardWidget(),
          ),
        ),
      ),
    );
  }
}
