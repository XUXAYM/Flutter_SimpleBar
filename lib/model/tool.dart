import 'package:meta/meta.dart';

enum ToolType {all, glass, barman_tool, decoration, other}

class Tool {
  final int id;
  String title;
  String description;
  ToolType type;
  int quantity;
  String imageSource;

  Tool({
    @required this.id,
    @required this.title,
    this.description = '',
    this.type = ToolType.other,
    this.imageSource = '',
    this.quantity = 1
  }) : assert(id >= 0 && title.isNotEmpty && type != ToolType.all);

  @override
  String toString() => "$title (id=$id)";
}