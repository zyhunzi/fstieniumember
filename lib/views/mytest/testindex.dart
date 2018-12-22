import 'package:flutter/material.dart';
import 'package:fstieniumember/tools/common.dart';
import 'package:fstieniumember/views/mytest/mycustomscrollview.dart';
import 'package:fstieniumember/views/mytest/myeventparas.dart';
import 'package:fstieniumember/views/mytest/mymsgengine.dart';

class TestIndex extends StatefulWidget {
  static const String routeName = '/mytest/mytestindex';
  @override
  _TestIndexState createState() => _TestIndexState();
}

class _TestIndexState extends State<TestIndex>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我的测试内容"),
        ),
        body: ListView(
          children: <Widget>[
            GestureDetector(
                onTapUp: (TapUpDetails details) {
                  Navigator.pushNamed(context, MyScrollView.routeName);
                },
                child: Text('测试滚动视图')),
            GestureDetector(
                onTapUp: (TapUpDetails details) {
                  Navigator.pushNamed(context, MyEvents.routeName);
                },
                child: Text('测试事件参数传递')),
            GestureDetector(
                onTapUp: (TapUpDetails details) {
                  print("CreateTokenring=${Common.CreateTokenring()}");
                  print("Input=${Common.CreateJsonInput('datalist', {'id':33})}");
                },
                child: Text('一般测试')),
            GestureDetector(
                onTapUp: (TapUpDetails details) {
                  Navigator.pushNamed(context, MyMsgEngine.routeName);
                },
                child: Text('消息测试'))
          ],
        ));
  }
}
