import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:fstieniumember/fsconfig.dart' show Constant;

class PageMessage extends StatefulWidget {
  @override
  _PageMessageState createState() => _PageMessageState();
}

class _PageMessageState extends State<PageMessage>
    with SingleTickerProviderStateMixin {
  TextEditingController _controller = new TextEditingController();

  WebSocketChannel channel;

  WebSocket socket;

  @override
  void initState() {
    super.initState();
//    WebSocket.connect(Constant.WebSocketServer).then((socket){
//      this.socket = socket;
//      print("连接: ${this.socket.readyState}");
//      this.socket.listen(_onMessage);
//      this.socket.done.then((e){
//        print("Down: $e");
//      });
//    });
    //_initmain();
  }

  void _initmain() async {
    channel = await IOWebSocketChannel.connect(Constant.WebSocketServer);
    channel.stream.listen(_onMessage,onError:_onError,onDone:_onDown,cancelOnError: true);
    channel.sink.add("hi");
  }

  void _onMessage(dynamic message){
    print("OnMessage:$message");
  }
  void _onError(dynamic error){
    print("OnError:$error");
  }
  void _onDown(){
    print("OnDown");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Form(
              child: new TextFormField(
                controller: _controller,
                decoration: new InputDecoration(labelText: '发送信息'),
              ),
            ),
//            new StreamBuilder(
//              stream: channel.stream,
//              builder: (context, snapshot) {
//                return new Padding(
//                  padding: const EdgeInsets.symmetric(vertical: 24.0),
//                  child: new Text(snapshot.hasData ? '${snapshot.data}' : ''),
//                );
//              },
//            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: '发送信息',
        child: new Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      //channel.sink.add(_controller.text);
      socket.add(_controller.text);
    }
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
