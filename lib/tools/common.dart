import 'package:fstieniumember/models/fsuser.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:convert';

class Common {
  static DateFormat formatToken = DateFormat("Myyyyd");
  static DateFormat formatDateTime = DateFormat("yyyy-MM-dd HH:mm:ss");
  static const String querytokenringkey =
      "mxdxx9v2o0uquqow0hc6sgvcx1jgbk301l9tcxv6lgb3c2ic895d844gbb950o1d73yiq4udwgume2a5shibpz26r2raxzg7o86i";
  static String CreateTokenring({DateTime time}) {
    if (time == null) {
      time = DateTime.now();
    }
    //DateTime time = DateTime.now();
    String strtime = formatToken.format(time);
    String result = "";
    for (int i = 0; i < strtime.length; i++) {
      String temp = "";
      if (i < strtime.length - 1) {
        temp = strtime.substring(i, i + 2);
      } else {
        temp = strtime.substring(i, i + 1);
      }
      int index = int.parse(temp);
      result += querytokenringkey[index];
    }
    return result;
  }

  static FSUser fsUser;

  static String GetUID() {
    if (fsUser != null) {
      return fsUser.uid;
    } else {
      return "xxx";
    }
  }

  static String CreateJsonInput(String flag, Map<String, dynamic> message) {
    DateTime now = DateTime.now();
    Map<String, dynamic> result = {
      "flag": flag,
      "currenttime": formatDateTime.format(now),
      "tokenring": CreateTokenring(time: now),
      "uid": GetUID(),
      "appname": "member",
      "clienttype": Platform.isAndroid
          ? "android"
          : (Platform.isIOS ? "apple" : "unknow"),
      "message": message
    };
    return jsonEncode(result);
  }
}
