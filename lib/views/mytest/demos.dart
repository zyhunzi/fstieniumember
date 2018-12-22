import 'package:flutter/cupertino.dart';
import 'package:fstieniumember/views/mytest/mycustomscrollview.dart';

class myDemo {
  const myDemo({this.routeName, this.buildRoute})
      : assert(routeName != null),
        assert(buildRoute != null);
  final String routeName;
  final WidgetBuilder buildRoute;
}

final List<myDemo> kAllGalleryDemos = _buildMyDemos();
List<myDemo> _buildMyDemos() {
  final List<myDemo> galleryDemos = <myDemo>[
    myDemo(
        routeName: MyScrollView.routeName,
        buildRoute: (BuildContext context) => MyScrollView())
  ];
}
