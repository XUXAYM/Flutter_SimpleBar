import 'package:flutter/foundation.dart';

import '../model/tool.dart';
import '../model/repository/tools_repository.dart';

class ToolsPoolNotifier with ChangeNotifier {
  final List<Tool> _tools = ToolsRepository.loadTools();

  List<Tool> loadIngredients() => _tools;

  Tool getById(int id) =>
      _tools.firstWhere((t) => t.id == id, orElse: () => null);

  Tool getByPosition(int index) =>
      (index < _tools.length && index >= 0) ? _tools[index] : null;
}
