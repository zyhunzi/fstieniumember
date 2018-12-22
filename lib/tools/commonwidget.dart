import 'package:flutter/material.dart';

class CommonWidget {
  static Widget PriceReal(String price) {
    return Text('￥$price',
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.red,
            fontWeight: FontWeight.w600,
            fontFamily: 'HelveticaMedium'));
  }
  static Widget PriceMSJ(String price){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('门市价',
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xffaaaaaa),
                fontFamily: 'HelveticaMedium')),
        Text('￥$price',
            style: TextStyle(
                fontSize: 16.0,
                color: Color(0xffaaaaaa),
                fontFamily: 'HelveticaMedium',
                decoration: TextDecoration.lineThrough)),
        Container(width: 10.0)
      ],
    );
  }
}
