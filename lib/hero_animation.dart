import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() {
  timeDilation = 5.0;
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
          appBar: AppBar(
            title: Text('Flutter App'),
          ),
          body: Center(child: Content())
        )
    );
  }
}

class PhotoHero extends StatelessWidget {
  PhotoHero({this.assetName, this.onPress});

  final String assetName;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: assetName,
      child: ClipOval(
        child: Center(
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Material(
              child: InkWell(
                onTap: onPress,
                child: Image.asset(assetName, fit: BoxFit.contain)
              )
            ),
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  Widget _buildDetailPage(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Card(
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: 280.0,
                height: 280.0,
                child: PhotoHero(
                  assetName: 'images/hedgehog.jpg',
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text('Hedgehog', textScaleFactor: 3.0,),
              )
            ],
          )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SizedBox(
          width: 60.0,
          height: 60.0,
          child: PhotoHero(
            assetName: 'images/hedgehog.jpg',
            onPress: () {
              Navigator.push(context, MaterialPageRoute(builder: _buildDetailPage));
            },
          )
        ),
      )
    );
  }
}


