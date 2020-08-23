import 'package:flutter/material.dart';

class DrawerMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('HEADER'),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.blueAccent),
              ),
              ListTile(
                title: InkWell(onTap: () {}, child: Text("로그아웃")),
              ),
              ListTile(
                title: Text("title 2"),
              ),
              ListTile(
                title: Text("title 3"),
              ),
              ListTile(
                title: Text("title 4"),
              ),
              ListTile(
                title: Text("title 5"),
              ),
              ListTile(
                title: Text("title 6"),
              ),
              ListTile(
                title: Text("title 7"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
