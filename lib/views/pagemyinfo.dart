import 'package:flutter/material.dart';
class PageMyInfo extends StatefulWidget {
  @override
  _PageMyInfoState createState() => _PageMyInfoState();
}

class _PageMyInfoState extends State<PageMyInfo> with SingleTickerProviderStateMixin {
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
    return SafeArea(
      top: true,
      child: Text("这是个人信息"),
    bottom: false,
    );
  }
}
