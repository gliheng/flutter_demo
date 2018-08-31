import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter App')),
        body: Center(child: InfoDisplay()),
      )
    );
  }
}


class InfoDisplay extends StatefulWidget {
  @override
  _InfoDisplayState createState() => _InfoDisplayState();
}

class _InfoDisplayState extends State<InfoDisplay> with SingleTickerProviderStateMixin {

  AnimationController controller;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          child: Image.asset('images/avatar.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Hi, I\'m Sam'),
              Text('I\'m a flutter developer')
            ],
          ),
        )
      ],
    );
  }
}
