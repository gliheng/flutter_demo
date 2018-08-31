import 'package:flutter/material.dart';

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
            appBar: AppBar(
                title: Text('Flutter Demo')
            ),
            body: AnimationExample()
        )
    );
  }
}


class AnimationExample extends StatefulWidget {
  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 5)
    );
    controller.forward();
  }

  _onTap() {
    if (controller.status == AnimationStatus.completed || controller.status == AnimationStatus.forward) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedBox(
            animation: controller,
            child: FlutterLogo()
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedBox extends StatelessWidget {
  final Widget child;
  final AnimationController animation;
  final Tween tween = Tween(begin: 100.0, end: 200.0);
  final Tween paddingTween = Tween(begin: 8.0, end: 16.0);
  AnimatedBox({this.animation, this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (BuildContext ctx, Widget child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
            width: tween.evaluate(animation),
            height: tween.evaluate(animation),
            child: Padding(
              padding: EdgeInsets.all(paddingTween.evaluate(animation)),
              child: child,
            ),
          );
        }
    );
  }
}