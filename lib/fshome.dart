import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fstieniumember/models/fsuser.dart';
import 'package:fstieniumember/tools/datasharedpreferences.dart';
import 'package:fstieniumember/views/pagecategory.dart';
import 'package:fstieniumember/views/pageindex.dart';
import 'package:fstieniumember/views/pagemessage.dart';
import 'package:fstieniumember/views/pagemyinfo.dart';
import 'package:fstieniumember/views/pageorders.dart';
import 'fsconfig.dart' show CommonColors, CommonSize, Constant;
import 'package:badge/badge.dart';
import 'package:fstieniumember/tools/common.dart';

class FSHome extends StatefulWidget {
  FSHome({Key key}) : super(key: key);
  @override
  _FSHomeState createState() => _FSHomeState();
}

class _FSHomeState extends State<FSHome> with AutomaticKeepAliveClientMixin {
  var tabImages;
  var appBarTitles;
  int _currentPageIndex = 0;
  int _tabIndex = 0;
  Timer _timer;
  int _secs = 0;
  bool _isonline = false;
  bool _isConnecting = false;
  var _pageController = new PageController(initialPage: 0);
  //WebSocketChannel _channel;
  WebSocket _webSocket;
  @override
  void initState() {
    super.initState();
    initData();
    _initmain();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      if (_secs >= 0) {
        _secs--;
      } else {
        _secs = 10;
        if (!_isonline && !_isConnecting) {
          _initmain();
        }
      }
    });
    DataSharedPreferences.dataQuery("user").then((json) {
      if (json == null) {
        print("没尼玛登录呢");
      } else {
        FSUser user = FSUser.fromJson(jsonDecode(json));
        Common.fsUser = user;
        print("user:${user.userName}");
      }
    });

    //    WebSocket.connect(Constant.WebSocketServer).then((socket){
//      this.socket = socket;
//      print("连接: ${this.socket.readyState}");
//      this.socket.listen(_onMessage);
//      this.socket.done.then((e){
//        print("Down: $e");
//      });
//    });
  }

  void _initmain() {
    if (Common.fsUser != null) {
      _isConnecting = true;
      print('开始连接...');
      WebSocket.connect(Constant.WebSocketServer).catchError((_) {
        print("catchError:$_");
        _isonline = false;
        _isConnecting = false;
      }).then((socket) {
        _isConnecting = false;
        if (socket != null && socket.readyState != null) {
          _isonline = socket.readyState == 1;
          print("完成连接:${socket.readyState}");
          if (_isonline) {
            _webSocket = socket;
            _webSocket.listen(_onMessage);
            _webSocket.handleError(_onError);
            _webSocket.done.then(_onDone);
            _socketLogIn();
          }
        } else {
          _isonline = false;
        }
      });
    }
  }

//  void _initmain2() async {
//    _isConnecting = true;
//    print("webSocket连接...");
//    _channel = await IOWebSocketChannel.connect(Constant.WebSocketServer);
//
//    print("webSocket连接完成${_channel.sink.toString()}");
//    _isConnecting = false;
//    _channel.stream.listen(_onMessage,
//        onError: _onError, onDone: _onDone, cancelOnError: true);
//    _socketLogIn();
//  }

  void _onMessage(dynamic message) {
    //_isonline = true;
    print("OnMessage:$message");
  }

  void _onError(dynamic error) {
    print("OnError:$error");
    _webSocket.close(9, 'sd').then((sd) {
      print("close.then:$sd");
    });
  }

  void _onDone(_) {
    print('done.then:$_');
    _isonline = false;
    //_channel.sink.close();
  }

  void _socketLogIn() {
    //_channel.sink.add(Common.CreateJsonInput("login", {"userid": "abc123", "username": "测尼玛试"}));
    if(Common.fsUser != null) {
      _webSocket.add(Common.CreateJsonInput(
          "login", {"userid": Common.fsUser.uid, "username": Common.fsUser.userName}));
    }
  }

  void initData() {
    tabImages = [
      [
        getTabImage('assets/images/tabbar/tabbar_icon_sy0.png'),
        getTabImage('assets/images/tabbar/tabbar_icon_sy1.png')
      ],
      [
        getTabImage('assets/images/tabbar/tabbar_icon_fl0.png'),
        getTabImage('assets/images/tabbar/tabbar_icon_fl1.png')
      ],
      [
        getTabImage('assets/images/tabbar/tabbar_icon_xx0.png'),
        getTabImage('assets/images/tabbar/tabbar_icon_xx1.png')
      ],
      [
        getTabImage('assets/images/tabbar/tabbar_icon_dd0.png'),
        getTabImage('assets/images/tabbar/tabbar_icon_dd1.png')
      ],
      [
        getTabImage('assets/images/tabbar/tabbar_icon_wd0.png'),
        getTabImage('assets/images/tabbar/tabbar_icon_wd1.png')
      ]
    ];
    appBarTitles = ['首页', '分类', '消息', '订单', '我的'];
  }

  Image getTabImage(path) {
    return Image.asset(path,
        width: CommonSize.TabBar_Icon_Width,
        height: CommonSize.TabBar_Icon_Height);
  }

  Widget getTabIcon(int curIndex) {
    Image tt;
    if (curIndex == _tabIndex) {
      tt = tabImages[curIndex][1];
    } else {
      tt = tabImages[curIndex][0];
    }
    if (curIndex == 2) {
//    return  Stack(
//      overflow: Overflow.visible,
//        children: <Widget>[
//          tt,
//          Positioned(
//
//            top: -8.0,
//            right: -8.0,
//
//            child: Container(
//              width: 16.0,
//              height: 16.0,
//              alignment: Alignment.center,
//                decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(8),
//                    color: Colors.red,
//                ),
//              child: Text("6",style: TextStyle(fontSize: 12.0,color: Colors.white))
//            ),
//          )
//        ],
//      );

      return Badge(
          positionTop: -10.0,
          positionRight: -10.0,
          textStyle: TextStyle(color: Colors.white, fontSize: 10.0),
          //borderSize: 0.0,
          //color: Colors.transparent,
          value: "15",
          child: tt);
    } else {
      return tt;
    }
  }

  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(
              color: Color(CommonColors.TabBar_Text_Color_1),
              fontSize: CommonSize.TabBar_Text_FontSize,
              fontWeight: FontWeight.bold));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(
              color: Color(CommonColors.TabBar_Text_Color_0),
              fontSize: CommonSize.TabBar_Text_FontSize,
              fontWeight: FontWeight.bold));
    }
  }

  void _pageChange(int index) {
    setState(() {
      _tabIndex = index;
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  PageIndex page1;
  PageCategory page2;
  PageMessage page3;
  PageOrders page4;
  PageMyInfo page5;

  @override
  void dispose() {
    _timer.cancel();
    //_channel.sink.close();
    super.dispose();
  }

  Scaffold _pageBody() {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            if (page1 == null) {
              page1 = PageIndex();
            }
            return page1;
          } else if (index == 1) {
            if (page2 == null) {
              page2 = PageCategory();
            }
            return page2;
          } else if (index == 2) {
            if (page3 == null) {
              page3 = PageMessage();
            }
            return page3;
          } else if (index == 3) {
            if (page4 == null) {
              page4 = PageOrders();
            }
            return page4;
          } else if (index == 4) {
            if (page5 == null) {
              page5 = PageMyInfo();
            }
            return page5;
          } else {
            return null;
          }
        },
        onPageChanged: (int index) {},
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
          BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
          BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          BottomNavigationBarItem(icon: getTabIcon(3), title: getTabTitle(3)),
          BottomNavigationBarItem(icon: getTabIcon(4), title: getTabTitle(4))
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (int index) {
          _pageController.animateToPage(index,
              duration: new Duration(seconds: 2),
              curve: new ElasticOutCurve(0.8));
          _pageChange(index);
        },
      ),
    );
  }

  BuildContext _buildContextcontext;
  @override
  Widget build(BuildContext context) {
    _buildContextcontext = context;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: _pageBody(),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: _buildContextcontext,
        builder: (context) => AlertDialog(
              title: Text('确定退出程序吗?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('暂不'),
                  onPressed: () => Navigator.pop(context, false),
                ),
                FlatButton(
                  child: Text('确定'),
                  onPressed: () => Navigator.pop(context, true),
                ),
              ],
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
