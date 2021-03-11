import '../tool.dart';

class ToolsRepository {
  static List<Tool> loadTools(ToolType type) {
    var allTools = <Tool> [
      Tool(
        id: 0,
        title: 'Rocks glass',
        type: ToolType.glass,
      ),
      Tool(
        id: 1,
        title: 'Jigger',
        type: ToolType.barman_tool,
      ),
      Tool(
        id: 2,
        title: 'Cocktail spoon',
        type: ToolType.barman_tool,
      ),
    ];
    if (type == ToolType.all) {
      return allTools;
    } else {
      return allTools.where((Tool t) {
        return t.type == type;
      }).toList();
    }
  }
}