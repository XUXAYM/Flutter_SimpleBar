import '../tool.dart';

class ToolsRepository {
  static List<Tool> loadTools() {
    var allTools = <Tool> [
      Tool(
        id: 0,
        title: 'Rocks glass',
        type: ToolType.glass,
        imageSource: 'https://i.ibb.co/0t6S8GJ/rocks.jpg',
      ),
      Tool(
        id: 1,
        title: 'Jigger',
        type: ToolType.barman_tool,
        imageSource: 'https://i.ibb.co/h8GzPb0/jigger.jpg',
      ),
      Tool(
        id: 2,
        title: 'Cocktail spoon',
        type: ToolType.barman_tool,
        imageSource: 'https://i.ibb.co/6ycQwjN/cocktail-spoon.jpg',
      ),
    ];
    return allTools;
  }
}