import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

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
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: AnimatedInfo(),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: AnimatedLoader(),
                ),
              ),
            ]),
          ),
        ));
  }
}

class AnimatedInfo extends StatefulWidget {
  @override
  _AnimatedInfoState createState() => _AnimatedInfoState();
}

class _AnimatedInfoState extends State<AnimatedInfo>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('前进'),
            onPressed: () {
              controller.forward();
            },
          ),
          RaisedButton(
            child: Text('后退'),
            onPressed: () {
              controller.reverse();
            },
          )
        ],
      ),
      AnimatedHeadline(controller: controller),
    ]);
  }
}

class AnimatedHeadline extends AnimatedWidget {
  final AnimationController controller;
  final Animation<double> avatarAnim;
  final Animation<double> titleTranslateAnim;
  final Animation<double> titleOpacityAnim;
  final Animation<double> textTranslateAnim;
  final Animation<double> textOpacityAnim;

  AnimatedHeadline({this.controller})
      : avatarAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller, curve: Interval(0.0, 0.6, curve: Curves.ease))),
        titleTranslateAnim = Tween(begin: 100.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.4, 0.7, curve: Curves.easeOut))),
        titleOpacityAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.4, 0.7, curve: Curves.easeOut))),
        textTranslateAnim = Tween(begin: 30.0, end: 0.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.7, 1.0, curve: Curves.easeOut))),
        textOpacityAnim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Interval(0.7, 1.0, curve: Curves.easeOut))),
        super(listenable: controller);

  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Opacity(
          opacity: avatarAnim.value,
          child: CircleAvatar(
            child: Image.asset('images/avatar.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Opacity(
                opacity: titleOpacityAnim.value,
                child: Transform(
                    transform: Matrix4.identity()
                      ..translate(titleTranslateAnim.value),
                    child: Text(
                      'Hi, I\'m Sam',
                      style: textTheme.headline,
                    )),
              ),
              Opacity(
                opacity: textOpacityAnim.value,
                child: Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, textTranslateAnim.value),
                    child: Text(
                      'I\'m a flutter developer',
                      style: textTheme.subhead,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}

class AnimatedLoader extends StatefulWidget {
  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('开始'),
            onPressed: () {
              controller.repeat();
            },
          ),
          RaisedButton(
            child: Text('停止'),
            onPressed: () {
              controller.reset();
            },
          )
        ],
      ),
      SizedBox(
        width: 100.0,
        height: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedRect(delay: Duration(milliseconds: 200), parent: controller),
            AnimatedRect(delay: Duration(milliseconds: 400), parent: controller),
            AnimatedRect(delay: Duration(milliseconds: 600), parent: controller),
            AnimatedRect(delay: Duration(milliseconds: 800), parent: controller),
            AnimatedRect(delay: Duration(milliseconds: 1000), parent: controller),
          ],
        ),
      ),
    ]);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class AnimatedRect extends StatefulWidget {
  final AnimationController parent;
  final Duration delay;

  AnimatedRect({this.parent, this.delay});

  @override
  _AnimatedRectState createState() => _AnimatedRectState();
}

class _AnimatedRectState extends State<AnimatedRect> with SingleTickerProviderStateMixin {
   Animation<double> grow;
   Animation<double> shrink;
   AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this);
    widget.parent.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.forward) {
        await Future.delayed(widget.delay);
        controller.forward();
      } else if (status == AnimationStatus.reverse) {
        await Future.delayed(widget.delay);
        controller.reverse();
      }
    });

    grow = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut)));

    shrink = Tween(begin: 0.0, end: -100.0).animate(CurvedAnimation(
    parent: controller,
    curve: Interval(0.5, 1.0, curve: Curves.easeOut)));
  }


   @override
   void dispose() {
     super.dispose();
     controller.dispose();
   }

   @override
   Widget build(BuildContext context) {
     return Container(
       margin: EdgeInsets.symmetric(horizontal: 2.0),
       width: 10.0,
       height: grow.value + shrink.value,
       decoration: BoxDecoration(
           color: Colors.blue,
           borderRadius: BorderRadius.all(Radius.circular(3.0))),
     );
   }
}
