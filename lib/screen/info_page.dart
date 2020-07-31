import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smartfarm/firebase/db_data/provider/mine_farmer_data.dart';
import 'package:smartfarm/shared/smartfarmer_constants.dart';
import 'package:smartfarm/firebase/database_provider.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: backgroundColor,
        //notchMargin: 12.0,

        child: Container(
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    //databaseProvider.send().then((_) => print("data send"));
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: infoButtonColor,
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<MineFarmerData>(context, listen: false).logoutFarmer();
          //FirebaseAuth.instance.signOut();
        },
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
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
            padding: EdgeInsets.only(
              left: 25.0,
              right: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: size.height * 0.078,
                ),
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
                      icon: Icon(Icons.menu),
                      iconSize: 25,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.notifications_none),
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
                    SizedBox(width: 10,),
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
            ),
          ),
        ],
      ),
    );
  }
}
