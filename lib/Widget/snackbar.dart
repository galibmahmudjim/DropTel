import 'package:flutter/material.dart';

snackBar(BuildContext context, String msg) {
  var snackdemo = SnackBar(
    content: Text(msg),
    backgroundColor: Colors.green,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
}
