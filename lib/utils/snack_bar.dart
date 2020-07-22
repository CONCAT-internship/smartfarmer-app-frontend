import 'package:flutter/material.dart';

void Snackbar(BuildContext context, String txt){
  final snackBar = SnackBar(content: Text(txt));
  Scaffold.of(context).showSnackBar(snackBar);
}