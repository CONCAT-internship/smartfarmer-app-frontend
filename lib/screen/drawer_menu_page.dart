import 'package:flutter/material.dart';

class DrawerMenuPage extends StatefulWidget {
  @override
  _DrawerMenuPageState createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  bool toggleValue = false;

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
                                transitionBuilder:
                                    (Widget child, Animation<double> animation) {
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

  toggleButton() {
    setState(() {
      toggleValue = !toggleValue;
    });
  }
}
