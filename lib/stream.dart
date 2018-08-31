import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        body: Center(child: MyBody())
      )
    );
  }
}

class MyBody extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  Stream<int> dataStream;
  Random rnd = new Random();

  @override
  void initState() {
    super.initState();
    dataStream = Stream.periodic(Duration(seconds: 1), (int i) {
      return rnd.nextInt(1000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: dataStream,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Text('num: ${snapshot.data}');
        })
    );
  }
}
