import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
printDebug(String message) {
  if (kDebugMode) debugPrint(message);
}

void showBtmSheet(
    {required BuildContext context,
      required Widget btmSheetWidget,
      Function? onThen}) {
  showModalBottomSheet(
    elevation: 20.0,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(35),
      ),
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    context: context,
    builder: (context) {
      return btmSheetWidget;
    },
  ).then((value) {
    if (onThen != null) onThen(value);
  });
}


enum ToastedStates { SUCCESS, ERROR, WARNING }

showToast(
    {required String msg,
      required ToastedStates state,
      ToastGravity gravity = ToastGravity.BOTTOM,
      Toast toastLength = Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color chooseToastColor(ToastedStates states) {
  Color color;
  switch (states) {
    case ToastedStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastedStates.ERROR:
      color = Colors.red;
      break;
    case ToastedStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}
String convertDateToString(DateTime date){
  String newDate= DateFormat('dd MMM yyyy').format(date);
  return newDate;
}
