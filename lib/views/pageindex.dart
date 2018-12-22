import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:fstieniumember/models/fsroom.dart';
import 'package:fstieniumember/tools/common.dart';
import 'package:fstieniumember/views/mytest/testindex.dart';
import 'package:fstieniumember/views/pagedatadetail.dart';
import 'pagelogin.dart';
import 'dart:ui';
import 'dart:convert';
import 'package:fstieniumember/models/fsuser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fstieniumember/controller/indexcontroller.dart'
    show IndexController;
import 'dart:async';
import 'package:fstieniumember/fsconfig.dart' show ListConfig;
import 'package:fstieniumember/tools/commonwidget.dart' show CommonWidget;
import 'package:fstieniumember/tools/datasharedpreferences.dart';

class PageIndex extends StatefulWidget {
  @override
  _PageIndexState createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<String> _linesecondtitles;
  List<FsRoom> _datas;
  ScrollController _scrollControllercontroller = new ScrollController();
  int _fieldid = 52;
  int _pageindex = 0;
  int _pagesize = 10;
  @override
  void initState() {
    _linesecondtitles = ["酒店客房", "最爱妈妈菜", "大浪淘沙", "健身中心"];
    _datas = [];
    _controller = AnimationController(vsync: this);
    super.initState();
    _scrollControllercontroller.addListener(_scrollListener);
    _loadFLData(_fieldid, _pageindex, _pagesize);
  }

  @override
  void dispose() {
    _scrollControllercontroller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _loadFLData(int fieldid, int pageNum, int pageSize) {
    print('load more pageNum=$pageNum,pageSize=$pageSize');
    IndexController.askApi(fieldid, pageNum, pageSize, (List<FsRoom> rooms) {
      setState(() {
        _datas.clear();
        _datas.addAll(rooms);
      });
    });
  }

  ///滑动图片
  SizedBox _lineFirst() {
    return SizedBox(
      height: 250.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.asset("assets/images/index/indexbanner$index.png",
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.2);
        },
        itemCount: 3,
        autoplay: true,
        //reverse: false,
        pagination:
////          new SwiperPagination(builder: SwiperPagination.fraction),
            new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
          color: Colors.black54,
          activeColor: Colors.white,
        )),
      ),
    );
  }

  ///检索条
  Row _rowSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0x66333333)),
            child: IconButton(
              icon: Image.asset("assets/images/index/indexuser.png",
                  width: 25.0, height: 25.0),
              onPressed: () {
                if (Common.fsUser == null) {
                  Navigator.of(context)
                      .push(new PageRouteBuilder(pageBuilder:
                          (BuildContext context, _, __) {
                    return new PageLogIn();
                  }, transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(
                      opacity: animation,
                      child: new RotationTransition(
                        turns: new Tween<double>(begin: 0.5, end: 1.0)
                            .animate(animation),
                        child: child,
                      ),
                    );
                  }))
                      .then((value) {
                    print('登录返回值 alue = $value');
                  });
                } else {
                  print("user:${Common.fsUser.userName}");
                }
              },
            )),
        Container(width: 10.0),
        Expanded(
          child: Container(
              height: 34.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Color(0xffffffff)),
              child: Center(
                  child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '请输入关键词搜索',
                  contentPadding: EdgeInsets.only(
                      left: 0.0, top: 6.0, bottom: 10.0, right: 0.0),
                  prefixIcon:
                      Icon(Icons.search, size: 30.0, color: Color(0x66333333)),
                ),
                autofocus: false,
              ))),
        ),
        Container(width: 10.0),
        Container(
            width: 40.0,
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0x66333333)),
            child: IconButton(
                icon: Image.asset("assets/images/index/indexcall.png",
                    width: 25.0, height: 25.0),
                onPressed: () {
                  // todo launch('tel:18666666666');
                  Navigator.pushNamed(context, TestIndex.routeName);
                }))
      ],
    );
  }

  ///酒店客房 最爱妈妈菜 大浪淘沙 健身中心
  SizedBox _lineSecond() {
    return SizedBox(
      //height: 200.0,
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
              child: _lineSecondItem(0)),
          Padding(
              padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
              child: _lineSecondItem(1)),
          Padding(
              padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 10.0),
              child: _lineSecondItem(2)),
          Padding(
              padding: EdgeInsets.only(
                  left: 5.0, top: 10.0, bottom: 10.0, right: 10.0),
              child: _lineSecondItem(3))
        ],
      ),
    );
  }

  Stack _lineSecondItem(int index) {
    return Stack(alignment: FractionalOffset.bottomCenter, children: <Widget>[
      Image.asset("assets/images/index/indexline2$index.png",
          width: (MediaQueryData.fromWindow(window).size.width - 35) / 4),
      Image.asset("assets/images/index/indexline2${index + 4}.png",
          width: (MediaQueryData.fromWindow(window).size.width - 35) / 4),
      Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(_linesecondtitles[index],
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'HelveticaMedium')))
    ]);
  }

  final double _IconHeight = 75.0;
  final double _IconWidth = 120.0;
  final double _titleHeight = 30.0;
  final double _detailHeight = 45.0;
  final double _pirceWidth = 110.0;

  void _toDetail(String eid) {
    Navigator.of(context)
        .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return new PageDataDetail(eid);
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return new FadeTransition(
        opacity: animation,
        child: new RotationTransition(
          turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
          child: child,
        ),
      );
    }))
        .then((value) {
      print('返回值');
    });
  }

  ///推荐列表项
  GestureDetector _listItem(int index) {
    return GestureDetector(
      onTapUp: (TapUpDetails details) {
        //showDialog(context: _context, child: AlertDialog(content: Text(_datas[index].Name)));
        //Navigator.pushNamed(context, PageDataDetail.routeName);
        _toDetail(_datas[index].Id);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(width: 10.0),
          CachedNetworkImage(
              width: _IconWidth,
              height: _IconHeight,
              placeholder: Container(
                  width: _IconWidth,
                  height: _IconHeight,
                  child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator())),
              imageUrl: _datas[index].Icon,
              fit: BoxFit.fill),
          Container(width: 10.0),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  height: _titleHeight,
                  child: Text(_datas[index].Name,
                      style: ListConfig.textStyleTitle)),
              Container(
                  alignment: Alignment.bottomLeft,
                  height: _detailHeight,
                  child:
                      Text(_datas[index].Des, style: ListConfig.textStyleDes))
            ],
          ) //Text(_datas[index].Name),
              ),
          Container(width: 10.0),
          SizedBox(
            width: _pirceWidth,
            height: _IconHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                    height: _titleHeight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: CommonWidget.PriceReal(_datas[index].Price1),
                    )),
                Container(
                    height: _detailHeight,
                    child: CommonWidget.PriceMSJ(_datas[index].Price0))
              ],
            ),
          )
        ],
      ),
    );
  }

  BuildContext _context;
  Widget _builderItemData(BuildContext context, int index) {
    _context = context;
    if (index == 0) {
      return _lineFirst();
    } else if (index == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _lineSecond(),
          Container(
            color: Color(0xccdddddd),
            height: 10.0,
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
              child: Text("推荐:",
                  style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'HelveticaMedium'),
                  textAlign: TextAlign.start))
        ],
      );
    } else {
      return Padding(
          padding: EdgeInsets.only(bottom: 10.0), child: _listItem(index - 2));
    }
  }

  void _scrollListener() {
    if (_scrollControllercontroller.position.pixels ==
        _scrollControllercontroller.position.maxScrollExtent) {
      _loadFLData(_fieldid, _pageindex, _pagesize);
    }
  }

  Future<Null> _refreshData() {
    final Completer<Null> completer = new Completer<Null>();
    _loadFLData(_fieldid, _pageindex, _pagesize);
    completer.complete(null);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset.topCenter,
      children: <Widget>[
        RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshData,
          child: ListView.builder(
              controller: _scrollControllercontroller,
              padding: const EdgeInsets.only(),
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: _datas.length + 2,
              itemBuilder: _builderItemData),
        ),
        Padding(
            padding: EdgeInsets.only(
                top: MediaQueryData.fromWindow(window).padding.top + 10.0,
                left: 10.0,
                right: 10.0),
            child: _rowSearch())
      ],
    );
  }
}
