import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fstieniumember/fsconfig.dart' show Constant;

class NetUtils {
  static Future<String> getApiData(String input) async {
    var httpClient = new HttpClient();
    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(Constant.ApiUrl));
      request.add(utf8.encode(input));
      var response = await request.close();
      if (response.statusCode == HttpStatus.OK) {
        result = await response.transform(Utf8Decoder()).join();
      } else {}
    } catch (exception) {}
    return result;
  }
}
