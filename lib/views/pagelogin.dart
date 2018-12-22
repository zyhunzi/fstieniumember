import 'dart:async';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:fstieniumember/fsconfig.dart' show CommonColors;
import 'package:fstieniumember/controller/logincontroller.dart';

class PageLogIn extends StatefulWidget {
  @override
  _PageLogInState createState() => _PageLogInState();
}

class _PageLogInState extends State<PageLogIn>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController _controllerUserName;
  TextEditingController _controllerYZM;
  TextStyle _styleCurrent;
  TextStyle _styleyzm1;
  TextStyle _styleyzm2;
  String _stringYZM;
  Timer _timer;
  int _secs = 0;

  @override
  void initState() {
    _controllerUserName = TextEditingController();
    _controllerYZM = TextEditingController();
    _brightness = Brightness.light;
    _controller = AnimationController(vsync: this);
    _stringYZM = "获取验证码";
    _styleyzm1 = TextStyle(color: Colors.red, fontSize: 20.0);
    _styleyzm2 = TextStyle(color: Colors.grey, fontSize: 20.0);
    _styleCurrent = _styleyzm1;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      if (_secs >= 0) {
        _secs--;
        if (_secs > 0) {
          setState(() {
            _styleCurrent = _styleyzm2;
            _stringYZM = "($_secs)秒      ";
          });
        } else if (_secs == 0) {
          setState(() {
            _styleCurrent = _styleyzm1;
            _stringYZM = "获取验证码";
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Brightness _brightness;
  Widget _pageBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: MediaQueryData.fromWindow(window).size.height,
          pinned: false,
          floating: true,
          snap: false,
          brightness: _brightness,
          leading: IconButton(
              icon: Image.asset(
                "assets/images/login/login_back.png",
                width: 26.0,
                height: 26.0,
              ),
              onPressed: () {
                setState(() {
                  _brightness = CommonColors.brightness;
                });
                Navigator.pop(context);
              }),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(children: <Widget>[
              Image.asset(
                "assets/images/login/login_bg.png",
                width: MediaQueryData.fromWindow(window).size.width,
                height: MediaQueryData.fromWindow(window).size.height,
                fit: BoxFit.fill,
              ),
              Column(
                children: <Widget>[
                  Container(height: 10.0),
                  Image.asset("assets/images/login/login_logo.png",
                      width: MediaQueryData.fromWindow(window).size.width),
                  //_line1(),
                  Padding(padding: EdgeInsets.all(10.0), child: _userName()),
                  Padding(padding: EdgeInsets.all(10.0), child: _yzm()),
                  Container(
                    height: 20.0,
                  ),
                  _buttonLogIn()
                ],
              )
            ]),
          ),
        ),
      ],
    );
  }

  Widget _bottomLine() {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Text("          ",
              style: TextStyle(decoration: TextDecoration.lineThrough)),
          Text("或用一下方式登录"),
          Text("          ",
              style: TextStyle(decoration: TextDecoration.lineThrough))
        ]),
        Row(
          children: <Widget>[
            Image.asset("assets/images/login/login_ic_wx.png"),
            Image.asset("assets/images/login/login_ic_qq.png"),
            Image.asset("assets/images/login/login_ic_wb.png")
          ],
        )
      ],
    );
    //return Text("或用以下方式登录");
  }

  FlatButton _buttonLogIn() {
    return FlatButton(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Image.asset(
            "assets/images/login/login_btn.png",
          ),
          const Text("登录",
              style: TextStyle(color: Colors.white, fontSize: 22.0))
        ],
      ),
      onPressed: () {
        if (_controllerUserName.text.isNotEmpty &&
            _controllerYZM.text.isNotEmpty) {
          LoginController.askApi_register(
              _controllerUserName.text, _controllerYZM.text, (String s) {
            //print("pagelogin _SendData callback $s");
            if (s == "0") {
              setState(() {
                _brightness = Brightness.dark;
              });
              Navigator.pop(context, "0");
            }
          });
        } else {
          print("登录失败 输入错误");
        }
//        setState(() {
//          _brightness = Brightness.dark;
//        });
//        print("你点了登录");
//        Fluttertoast.showToast(
//            msg: "你点了登录",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white
//        );
      },
    );
  }

  TextField _userName() {
    return TextField(
        controller: _controllerUserName,
        keyboardType: TextInputType.text,
        style: TextStyle(fontSize: 20.0, color: Color(0xff333333)),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(fontSize: 20.0, color: Color(0xffcccccc)),
          prefixIcon: Image.asset("assets/images/login/login_input_un.png"),
        ),
        autofocus: false);
  }

  void _sendData() {
    if (_controllerUserName.text.isNotEmpty) {
      LoginController.askApi_yzm(_controllerUserName.text, (String s) {
        print("pagelogin _SendData callback $s");
      });
    } else {
//        Fluttertoast.showToast(
//            msg: "手机号不能空!",
//            toastLength: Toast.LENGTH_SHORT,
//            gravity: ToastGravity.CENTER,
//            timeInSecForIos: 1,
//            backgroundColor: Colors.red,
//            textColor: Colors.white
//        );
    }
  }

  Stack _yzm() {
    return Stack(alignment: AlignmentDirectional.centerEnd, children: <Widget>[
      TextField(
          controller: _controllerYZM,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 20.0, color: Color(0xff333333)),
          decoration: InputDecoration(
              hintText: '请输入验证码',
              hintStyle: TextStyle(fontSize: 20.0, color: Color(0xffcccccc)),
              prefixIcon:
                  Image.asset("assets/images/login/login_input_yzm.png")),
          autofocus: false),
      GestureDetector(
          onTap: () {
            if (_secs <= 0) {
              if (_controllerUserName.text.isNotEmpty) {
                print("尼玛1");
                _secs = 60;
                LoginController.askApi_yzm(_controllerUserName.text,
                    (String s) {
                  print("pagelogin _SendData callback $s");
                });
              } else {
                print("尼玛2");
              }
            } else {
              print("尼玛3");
            }
          },
          child: Text(
            _stringYZM,
            style: _styleCurrent,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          _brightness = CommonColors.brightness;
        });
        return Future.value(true);
      },
      child: _pageBody(),
    );
  }
}
