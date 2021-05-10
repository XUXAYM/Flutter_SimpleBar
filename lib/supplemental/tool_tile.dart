import 'package:flutter/material.dart';

import '../model/tool.dart';

import 'circle_image.dart';

class ToolListTile extends StatelessWidget {
  ToolListTile(this.tool, {this.quantity: 1})
      : assert(tool != null),
        assert(quantity != null && quantity > 0);

  final int quantity;
  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExcludeSemantics(
        child: CircleImage(src: tool.imageSource,),
      ),
      title: Text(tool.title),
      subtitle: Text(quantity.toString() + ' pcs'),
    );
  }
}