import 'package:fstieniumember/models/fsuser.dart';
import 'package:fstieniumember/tools/callbackfunction.dart';
import 'package:fstieniumember/tools/common.dart';
import 'package:fstieniumember/tools/netutils.dart';
import 'dart:convert';
import 'package:fstieniumember/tools/datasharedpreferences.dart';

class LoginController {
  static void askApi_yzm(String mobile, CallbackString s) {
    String input =
        Common.CreateJsonInput("verificationcode", {"mobile": mobile});
    NetUtils.getApiData(input).then((json) {
      dynamic ss = jsonDecode(json);
      if (ss["success"] != null) {
        if (ss["success"].toString().trim() == "0") {
          s("发送成功");
          print(ss["message"]);
        } else {
          if (ss["errormessage"] != null &&
              ss["errormessage"].toString().trim() != "") {
            s(ss["errormessage"].toString().trim());
          } else {
            s(ss["success"].toString().trim());
          }
        }
      } else {
        s("-1");
      }
    }).catchError((error) {
      print(error);
    });
  }

  static void askApi_login(String mobile, String yzm, CallbackString s) {
    String input = Common.CreateJsonInput("login",
        {"username": mobile, "password": mobile, "verificationcode": yzm});
    NetUtils.getApiData(input).then((json) {
      dynamic ss = jsonDecode(json);
      if (ss["success"] != null) {
        if (ss["success"].toString().trim() == "0") {
          s("登录成功");
          //print(ss["message"]);
        } else {
          if (ss["errormessage"] != null &&
              ss["errormessage"].toString().trim() != "") {
            s(ss["errormessage"].toString().trim());
          } else {
            s(ss["success"].toString().trim());
          }
        }
      } else {
        s("-1");
      }
    }).catchError((error) {
      print(error);
    });
  }

  static void askApi_register(String mobile, String yzm, CallbackString s) {
    String input = Common.CreateJsonInput("register",
        {"username": mobile, "password1": mobile, "password2": mobile, "verificationcode": yzm, "usernametype": "mobile"});
    NetUtils.getApiData(input).then((json) {
      dynamic ss = jsonDecode(json);
      if (ss["success"] != null) {
        if (ss["success"].toString().trim() == "0" || ss["success"].toString().trim() == "4") {
          s("0");
          FSUser user = FSUser.fromJson(ss["message"]);
          DataSharedPreferences.dataAdd("user",user.toJson());
          Common.fsUser = user;
//          DataSharedPreferences.dataQuery("user").then((_json){
//            FSUser user2 = FSUser.fromJson(jsonDecode(_json));
//            print("登录成功_user:${user2.userName} savejson:${_json}");
//          });
        } else {
          if (ss["errormessage"] != null &&
              ss["errormessage"].toString().trim() != "") {
            s(ss["errormessage"].toString().trim());
          } else {
            s(ss["success"].toString().trim());
          }
        }
      } else {
        s("-1");
      }
    }).catchError((error) {
      print(error);
    });
  }
}
