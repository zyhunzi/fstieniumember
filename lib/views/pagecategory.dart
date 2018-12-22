import 'package:flutter/material.dart';
import 'package:fstieniumember/views/mytest/parent.dart';

class PageCategory extends StatefulWidget {
  @override
  _PageCategoryState createState() => _PageCategoryState();
}

class _PageCategoryState extends State<PageCategory>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    //print("真他妈奇怪");
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    //print("真尼玛奇怪");
    _controller.dispose();
    super.dispose();
  }

  Parent _parent;
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blue);
  }
}
