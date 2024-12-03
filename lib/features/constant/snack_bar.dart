import 'package:flutter/material.dart';
import 'package:project_machine_test_2/features/resources/color_resources.dart';

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: TextStyle(color: ColorResources.blackColor, fontWeight: FontWeight.bold),
    ),
    backgroundColor: ColorResources.whiteColor,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
