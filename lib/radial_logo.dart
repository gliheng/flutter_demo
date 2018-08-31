import 'dart:math';
import 'package:flutter/material.dart';

class RadialLayoutDelegate extends MultiChildLayoutDelegate {
  int itemCount;
  double radius;
  RadialLayoutDelegate({this.itemCount = 0, this.radius});

  @override
  performLayout(Size size) {
    var center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < itemCount; i++) {
      var id = 'widget ${i}';
      Size c = layoutChild(id, BoxConstraints.loose(size));
      positionChild(id, center.translate(-c.width/2 + radius * cos(2*pi/itemCount*i), -c.height/2 + radius * sin(2*pi/itemCount*i)));
    }
  }

  @override
  bool shouldRelayout(RadialLayoutDelegate oldDelegate) {
    return itemCount != oldDelegate.itemCount;
  }
}

class RadialLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var n = 20;
    return CustomMultiChildLayout(
      delegate: RadialLayoutDelegate(
        itemCount: n,
        radius: 100.0,
      ),
      children: List.generate(n, (i) {
        return LayoutId(
          id: 'widget ${i}',
          child: FlutterLogo()
        );
      })
    );
  }
}