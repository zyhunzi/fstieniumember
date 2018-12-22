import 'package:flutter/material.dart';
import 'package:flutter_msg_engine/flutter_msg_engine.dart';
class MyMsgEngine extends StatefulWidget implements MsgProcHandler<String>{
  static const String routeName = '/mytest/mymsgengine';
  final int msgid;
  MyMsgEngine({this.msgid=150});
  @override
  _MyMsgEngineState createState() {

    MsgEngine.instance.register(this, msgid);
    return _MyMsgEngineState();}

  void processMsg(MsgPack<String> msg){
    print("MyApp: " + msg.data);
  }
}

class _MyMsgEngineState extends State<MyMsgEngine> with SingleTickerProviderStateMixin {
  AnimationController _controller;
String _string;

  @override
  void initState() {
    _string='';
    _controller = AnimationController(vsync: this);
    super.initState();
    MsgEngine.instance.start();
  }

  @override
  void dispose() {
    MsgEngine.instance.stop();
    //MsgEngine.instance.unRegister(msgid);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('测试消息'),centerTitle: true,actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.create),
          tooltip: '编辑',
          onPressed: () {
            MsgEngine.instance.sendMsg(MsgPackData<String>(msgId: widget.msgid, data: "message id is ${widget.msgid}"));
          },
        )
      ],),
      body: Text(""),
    );
  }
}
