import 'dart:convert';
import 'package:fstieniumember/models/fsroom.dart';
import 'package:fstieniumember/tools/common.dart';
import 'package:fstieniumember/tools/netutils.dart';
import 'package:fstieniumember/tools/callbackfunction.dart';

class IndexController {
  static void askApi(int fieldid, int pageNum, int pageSize, CallbackFSListRoom s) {
    String input = Common.CreateJsonInput("datalist", {"fieldid":fieldid,"index":pageNum,"count":pageSize});
    NetUtils.getApiData(input).then((json) {
      dynamic ss = jsonDecode(json);
      List<dynamic> flModels = ss['message']['list'];
      List<FsRoom> rooms=[];
      for(int i=0;i<flModels.length;i++){
        FsRoom r = FsRoom.fromJson(flModels[i]);
        rooms.add(r);
      }
      s(rooms);
    }).catchError((error) {
      print(error);
    });
  }
}

//Future<List<FsRoom>> _getData(int pageNum, int pageSize) async {
//  var httpClient = new HttpClient();
//  String input =
//      "{\"tokenring\": \"uvsxchqx\",\"currenttime\": \"2018-12-13 09:17:45\",\"flag\": \"datalist\",\"uid\": \"\",\"appname\": \"member\",\"clienttype\": \"android\",\"message\": {\"fieldid\": 52,\"index\": 0,\"count\": 10}}";
//  List flModels;
//  try {
//    var request = await httpClient.postUrl(Uri.parse(Constant.ApiUrl));
//    request.add(utf8.encode(input));
//    var response = await request.close();
//    if (response.statusCode == HttpStatus.OK) {
//      var json = await response.transform(Utf8Decoder()).join();
//      //print(json);
//      dynamic ss = jsonDecode(json);
//      if (ss['message'] != null && ss['message']['list'] != null) {
//        flModels = ss['message']['list'];
//        for (Map<String, dynamic> element in flModels) {
//          if (element['source'] != null) {
//            break;
//          }
//        }
//      } else {}
//    } else {}
//  } catch (exception) {}
//
//  return flModels.map((model) {
//    return new FsRoom.fromJson(model);
//  }).toList();
//}
