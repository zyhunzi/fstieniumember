import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fstieniumember/fsevents.dart';

class ChildOne extends StatefulWidget {
  @override
  ChildOneState createState() => new ChildOneState();
}

class ChildOneState extends State<ChildOne> {
  String data = '无';
  // StreamSubscription subscription;
  StreamSubscription subscription;
  void initState() {
    subscription = eventBus.on<MyEvent>().listen((MyEvent data) =>
        show(data.text)
    );
//    subscription.resume();
//    subscription.pause();
//    subscription.cancel();
//    subscription = eventBus.on<UserLoggedInEvent>().listen((event) {
//      print(event.user);
//    });

  }

  void show(String val) {
    setState(() {
      data= val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        decoration: BoxDecoration(color: Colors.blue[100]),
        child: new Center(
            child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(bottom: 15.0),
                    child:  new Text('子组件1'),
                  ),
                  new Text('子组件2传来的值:$data'),
                ]
            )
        )
    );
  }
}