import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fstieniumember/tools/fslocalizations.dart';
import 'package:fstieniumember/views/mytest/mycustomscrollview.dart';
import 'package:fstieniumember/views/mytest/myeventparas.dart';
import 'package:fstieniumember/views/mytest/mymsgengine.dart';
import 'package:fstieniumember/views/mytest/testindex.dart';
import 'fshome.dart';
import 'fsconfig.dart' show CommonColors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FSLocalizationsDelegate.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US'),
        ],
        routes: <String, WidgetBuilder>{
          TestIndex.routeName: (BuildContext context) => new TestIndex(),
          MyScrollView.routeName: (BuildContext context) => new MyScrollView(),
          MyEvents.routeName: (BuildContext context) => new MyEvents(),
          MyMsgEngine.routeName: (BuildContext context) => new MyMsgEngine(),
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //brightness: CommonColors.brightness,
            primaryColorBrightness: CommonColors.brightness,
            //primarySwatch: Colors.blue,
            cardColor: Color(0xff121212),
            canvasColor: Color(0xfffefefe)),
        home: FSHome());
  }
}
