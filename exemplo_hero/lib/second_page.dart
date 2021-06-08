import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final IconData iconData;
  final String tag;
  final String text;
  const SecondPage(
      {Key? key, required this.iconData, required this.tag, required this.text})
      : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: Container(
            margin: const EdgeInsets.all(5.0),
            child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                  child: Icon(
                    widget.iconData,
                    color: Colors.white,
                  ),
                  tag: widget.tag),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
