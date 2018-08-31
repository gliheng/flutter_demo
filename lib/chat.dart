import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  AnimationController animationController;

  ChatMessage({this.text, this.animationController}) {
    this.animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        child: Text(text),
      )
    );
  }
}


class ChatView extends StatefulWidget {
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  final _messages = List<ChatMessage>();
  final _textController = TextEditingController();
  bool _isEditing = false;

  _handleSubmit(String s) {
    _textController.clear();
    _isEditing = false;
    setState(() {
      _messages.insert(0, ChatMessage(
        text: s,
        animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 700))
      ));
    });
  }

  @override
  void dispose() {
    for (ChatMessage msg in _messages) {
      msg.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, i) => _messages[i],
            itemCount: _messages.length
          )
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4.0)],
          ),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: _textController,
                    onSubmitted: _handleSubmit,
                    onChanged: (text) {
                      setState(() {
                        _isEditing = text.length != 0;
                      });
                    },
                    decoration: InputDecoration.collapsed(
                        hintText: 'Send a message'
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(Icons.send),
                onPressed: _isEditing?
                    () => _handleSubmit(_textController.text)
                    : null,
              )
            ],
          )
        ),
    ]);
  }
}
