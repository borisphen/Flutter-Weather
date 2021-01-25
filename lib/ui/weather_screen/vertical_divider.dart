import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20, child: VerticalDivider(color: Colors.blueGrey));
  }
}
