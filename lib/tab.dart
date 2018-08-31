import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.red,
          brightness: Brightness.light,
        ),
        home: Scaffold(
            appBar: AppBar(
                title: Text('Tab demo')
            ),
            body: Home()
        )
    );
  }
}

const TABS = [
  {'icon': Icons.music_note, 'name': 'music'},
  {'icon': Icons.star, 'name': 'star'},
  {'icon': Icons.map, 'name': 'map'},
  {'icon': Icons.palette, 'name': 'palette'},
  {'icon': Icons.traffic, 'name': 'traffic'},
];

class Home extends StatelessWidget {
  @override  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: TabBarView(
        children: TABS.map((var item) {
          return Icon(item['icon'], size: 100.0);
        }).toList(),
      ),
    );
  }
}