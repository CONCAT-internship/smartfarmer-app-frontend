import 'package:flutter/material.dart';
import 'package:smartfarm/forms/graph_box.dart';
import 'package:smartfarm/forms/header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        Header(size: size),
        Graph_Box(),
      ],
    );
  }
}
