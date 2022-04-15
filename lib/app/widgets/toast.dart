import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

showToast({
  String msg = "This is message",
}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 16);
}
