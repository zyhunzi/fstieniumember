import 'dart:convert';
import 'package:fstieniumember/models/fsroom.dart';
import 'package:fstieniumember/tools/common.dart';
import 'package:fstieniumember/tools/netutils.dart';
import 'package:fstieniumember/tools/callbackfunction.dart';

class DetailController {
  static void askAPI(String eid, CallbackFSRoom s) {
    String input = Common.CreateJsonInput("datadetail", {"id":eid});
    NetUtils.getApiData(input).then((json) {
      FsRoom room = FsRoom.fromJson(jsonDecode(json.toString())["message"]);
      s(room);
    }).catchError((error) {
      print(error);
    });
  }
}
