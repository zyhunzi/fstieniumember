import 'package:flutter/material.dart';
import 'package:fstieniumember/controller/detailcontroller.dart'
    show DetailController;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fstieniumember/fsconfig.dart' show CommonColors;
import 'package:fstieniumember/models/fsroom.dart';

class PageDataDetail extends StatefulWidget {
  final String eid;
  PageDataDetail(this.eid);

  @override
  _PageDataDetailState createState() => _PageDataDetailState(eid);
}

Widget _backImapg;
String _DataName = "";
String _Icon = "";

enum AppBarBehavior { normal, pinned, floating, snapping }

class _PageDataDetailState extends State<PageDataDetail>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final String eid;
  _PageDataDetailState(this.eid);

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  final double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  @override
  void initState() {
    _brightness = Brightness.light;
    super.initState();
    _controller = AnimationController(vsync: this);
    _backImapg=Container(color: Color(0x00000000));
    _loadFLData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _loadFLData() {
    DetailController.askAPI(eid, (FsRoom room) {
      setState(() {
        _DataName = room.Name;
        _Icon = room.Icon;
        if(_Icon!=null&&_Icon.startsWith("http")){
          _backImapg=CachedNetworkImage(
              placeholder:
              Container(child: CircularProgressIndicator()),
              imageUrl: _Icon,
              fit: BoxFit.fill);
        }
        //print("Id=${room.Id},Name=${room.Name},Icon=$_Icon");
      });
    });
  }

  Brightness _brightness;
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: (){
        setState(() {
          _brightness = CommonColors.brightness;
        });
        return  Future.value(true);
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
                expandedHeight: _appBarHeight,
                pinned: _appBarBehavior == AppBarBehavior.pinned,
                floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
                snap: _appBarBehavior == AppBarBehavior.snapping,
                brightness: _brightness,
                title: Text("这是详情"),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.create),
                    tooltip: '编辑',
                    onPressed: () {
                      _scaffoldKey.currentState.showSnackBar(
                          const SnackBar(content: Text("此处不允许编辑.")));
                    },
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(_DataName),
                  background: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      _backImapg,
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, -0.4),
                            colors: <Color>[Color(0x60000000), Color(0x00000000)],
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
