import 'package:meta/meta.dart';

enum ToolType {all, glass, barman_tool, decoration, other}

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
}