import 'package:flutter/material.dart';

void alertSnackbar(BuildContext context, String txt){
  final snackBar = SnackBar(
    backgroundColor: Colors.red[400],
    duration: Duration(seconds: 10),
    content: Text(txt),
    action: SnackBarAction(
      label: "확인",
      textColor: Colors.white,
      onPressed: () {},
    ),
  );

  Scaffold.of(context).showSnackBar(snackBar);
}

