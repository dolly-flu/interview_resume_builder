import 'package:fluttertoast/fluttertoast.dart';
import '../../utils/colors.dart';

Future<void> commonToast(String msg) {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColor.cBackGround,
    textColor: AppColor.cLabel,
    fontSize: 16.0,
  );
}
