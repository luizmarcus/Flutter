import 'package:flutter/material.dart';

class Fragment extends StatelessWidget {

  final String title;

  const Fragment(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title),
    );
  }
}
