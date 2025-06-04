import 'package:flutter/material.dart';

SnackInfo({required BuildContext context, required String title}) {
  SnackBar snackBar = SnackBar(content: Text(title));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
