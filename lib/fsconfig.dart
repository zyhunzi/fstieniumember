import 'package:flutter/material.dart';

class CommonSize {
  ///TabBar图标文本字体大小
  static const double TabBar_Text_FontSize = 12.0;

  ///TabBar图标宽度
  static const double TabBar_Icon_Width = 24.0;

  ///TabBar图标高度
  static const double TabBar_Icon_Height = 24.0;
}

class CommonColors {
  ///未选中时文本颜色
  static const int TabBar_Text_Color_0 = 0xff666666;

  ///选中时文本颜色
  static const int TabBar_Text_Color_1 = 0xffff0000;

  static const Brightness brightness = Brightness.dark;
}

class Constant {
  //static const String ApiUrl = "http://www.feishun.net:8889/app.ashx";
  static const String _serveraddress = "192.168.21.102";
  //static const String _serveraddress = "www.feishun.net";
  static const String ApiUrl = "http://$_serveraddress:8888/app.ashx";
  static const String ImagePath = "http://$_serveraddress:8888/Upload/";
  static const String WebSocketServer = "ws://$_serveraddress:8080";
}

class ListConfig {
  static const double FontSizeTitle = 22.0;
  static const double FontSizeDes = 16.0;

  static const TextStyle textStyleTitle =
      TextStyle(fontSize: ListConfig.FontSizeTitle, color: Color(0xff000000));
  static const TextStyle textStyleDes =
      TextStyle(fontSize: ListConfig.FontSizeDes, color: Color(0xff666666));
}
