import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

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
      home: MyHomePage()
    );
  }
}

class Panel {
  String name;
  IconData icon;

  Panel({this.name, this.icon});
}

class MyHomePage extends StatefulWidget {
  static final List<Panel> panels = [
    Panel(name: 'Drive', icon: Icons.drive_eta),
    Panel(name: 'Walk', icon: Icons.directions_walk),
    Panel(name: 'Bike', icon: Icons.directions_bike),
    Panel(name: 'Car', icon: Icons.directions_car),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Panel currentPanel = MyHomePage.panels[0];
  GlobalKey key = GlobalKey(debugLabel: 'MyHomePage > Stack');
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: 600),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get panelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  double get panelHeight {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  _toggleVisibility() {
    _controller.fling(velocity: panelVisible? -2.0 : 2.0);
  }

  _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating) return;
    _controller.value -= details.primaryDelta / (panelHeight ?? details.primaryDelta);
  }

  _handleDragEnd(DragEndDetails details) {
    final double v = details.velocity.pixelsPerSecond.dy / panelHeight;
    if (v > 0.0) {
      _controller.fling(velocity: math.min(-2.0, -v));
    } else if (v < 0.0) {
      _controller.fling(velocity: math.max(2.0, -v));
    } else {
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
    }
  }

  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    var panelSize = constraints.biggest;
    var titleHeight = 36;
    var top = panelSize.height - titleHeight;
    final Animation<RelativeRect> rectAnimation = new RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, top, 0.0, top - panelSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut
    ));

    return Stack(
      key: key,
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: ListTileTheme(
            textColor: Colors.white,
            child: Column(
              children: MyHomePage.panels.map((panel) {
                bool selected = panel == currentPanel;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    child: ListTile(
                      title: Text(panel.name),
                      onTap: () {
                        setState(() {
                          currentPanel = panel;
                          _controller.fling(velocity: 2.0);
                        });
                      },
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4.0))
                    ),
                    color: selected ? Colors.white.withOpacity(0.25) : Colors.transparent,
                  ),
                );
              }).toList()
            ),
          ),
        ),
        PositionedTransition(
          rect: rectAnimation,
          child: GestureDetector(
            onTap: _toggleVisibility,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: ContentPanel(currentPanel)
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Backdrop demo'),
        actions: <Widget>[
          IconButton(
              onPressed: _toggleVisibility,
              icon: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _controller.view,
              )
          )
        ],
      ),
      body: LayoutBuilder(builder: _buildBody)
    );
  }
}

class ContentPanel extends StatelessWidget {
  final Panel panel;
  ContentPanel(this.panel);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(panel.name, style: TextStyle(fontSize: 20.0,)),
          ),
          Expanded(
            child: Center(
              child: Icon(panel.icon, size: 50.0,)
            ),
          )
        ],
      ),
    );
  }
}