import 'package:flutter/material.dart';

class InfoBlockCard extends StatelessWidget {
  InfoBlockCard({this.children});

  final List<Widget> children;
  final Color linesColor = Color(0xFFF7F7F7);
  final double verticalPadding = 8.0;
  final double horizontalPadding = 8.0;

  @override
  Widget build(BuildContext context) {
    if (children != null) {
      for (int i = 1; i < children.length; i += 2) {
        final divider = Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Divider(
              color: linesColor,
              thickness: 1.0,
            ));
        children.insert(i, divider);
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: linesColor, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children ?? [],
      ),
    );
  }
}