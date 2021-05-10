import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

enum ToolType {
  all,
  glass,
  barman_tool,
  presentation,
  device,
  other,
}

class Tool {
  final int id;
  final String title;
  final String description;
  final ToolType type;
  final String imageSource;

  Tool({
    @required this.id,
    @required this.title,
    this.description = '',
    this.type = ToolType.other,
    this.imageSource = '',
  }) : assert(id >= 0 && title.isNotEmpty && type != ToolType.all);

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Tool && other.id == id;

  static Tool fromMap(Map mapTool) => Tool(
        id: mapTool['id'],
        title: mapTool['title'],
        description: mapTool['description'],
        imageSource: mapTool['imageSource'],
        type: ToolType.values
            .firstWhere((e) => describeEnum(e) == mapTool['group']),
      );

  static Map toMap(Tool tool) => {
        'id': tool.id,
        'title': tool.title,
        'description': tool.description,
        'imageSource': tool.imageSource,
        'type': describeEnum(tool.type),
      };
}
