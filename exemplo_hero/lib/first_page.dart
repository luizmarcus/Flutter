import 'package:exemplo_hero/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirstPage extends StatefulWidget {
  final String title;
  const FirstPage({Key? key, required this.title}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        color: Colors.purple,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getItem(Icons.tag, "Item 1", "item1"),
              _getItem(Icons.translate, "Item 2", "item2"),
              _getItem(Icons.input, "Item 3", "item3"),
              _getItem(Icons.message, "Item 4", "item4"),
            ]),
      ),
    );
  }

  Widget _getItem(IconData iconData, String name, String tag) =>
      GestureDetector(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Hero(child: Icon(iconData), tag: tag),
                Expanded(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (_, __, ___) => SecondPage(
              iconData: iconData,
              tag: tag,
              text: name,
            ),
          ),
        ),
      );
}
