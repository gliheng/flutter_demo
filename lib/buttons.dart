import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('App'),
        ),
        body: Home(),
      )
    );
  }
}

var btns = [
  {
    'name': 'RaisedButton',
    'widget': RaisedButton(child: Text('Hello'), onPressed: () {}),
  }, {
    'name': '灰掉的RaisedButton',
    'widget': RaisedButton(child: Text('Hello')),
  }, {
    'name': '带图标的RaisedButton',
    'widget': RaisedButton.icon(icon: Icon(Icons.apps), label: Text('Hello'), onPressed: () {}),
  }, {
    'name': 'OutlineButton',
    'widget': OutlineButton(child: Text('Hello'), onPressed: () {})
  }, {
    'name': '带图标的OutlineButton',
    'widget': OutlineButton.icon(icon: Icon(Icons.apps), label: Text('Hello'), onPressed: () {}),
  }, {
    'name': 'FlatButton',
    'widget': FlatButton(child: Text('Hello'), onPressed: () {})
  }, {
    'name': '带图标的FlatButton',
    'widget': FlatButton.icon(icon: Icon(Icons.apps), label: Text('Hello'), onPressed: () {})
  }, {
    'name': 'IconButton',
    'widget': IconButton(
      icon: Icon(Icons.thumb_up),
      onPressed: () {},
      color: Colors.blue,
    ),
  }, {
    'name': 'DropdownButton',
    'widget': DropdownButton(
      onChanged: (String s) {
        print('$s is selected');
      },
      value: 'Orange',
      items: ['Apple', 'Orange', 'Watermelon'].map((s) => DropdownMenuItem(
        value: s,
        child: Text(s),
      )).toList(),
    )
  }, {
    'name': 'FloatingActionButton',
    'widget': FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {},
    )
  },
];

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: btns.map((m) => ListTile(
        leading: Text(m['name']),
        trailing: m['widget'],
      )).toList(),
    );
  }
}