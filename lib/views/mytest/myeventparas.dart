import 'package:flutter/material.dart';
import 'package:fstieniumember/views/mytest/parent.dart';

class MyEvents extends StatefulWidget {
  static const String routeName = '/mytest/myevents';
  @override
  _MyEventsState createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents>
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

  Parent _parent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这是事件")),
        body: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((c, o) {
            if (_parent == null) {
              _parent = Parent();
            }
            return _parent;
          }, childCount: 1),
        )
      ],
    ));
  }
}
