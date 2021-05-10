import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/tool.dart';
import '../model/repository/tools_repository.dart';

String langCode = 'ru';
String collectionName = 'tool';
String subCollectionName = 'locale';

class ToolsPoolNotifier with ChangeNotifier {
  final List<Tool> _tools = ToolsRepository.loadTools();
  final collection = FirebaseFirestore.instance.collection(collectionName);

  List<Tool> loadIngredients() => _tools;

  Future<Tool> getByFutureId(int id) async{
    var snapshot = await collection.where('id', isEqualTo: id).get();
    var doc = snapshot.docs[0];
    var mappedToolData = doc.data();
    var localeDataSnapshot = doc.reference.collection('locale').doc('ru');
    var localeData = await localeDataSnapshot.get();
    mappedToolData.addAll( localeData.data());
    print(mappedToolData['title']);

    return Tool.fromMap(mappedToolData);
  }

  Tool getById(int id) =>
      _tools.firstWhere((t) => t.id == id, orElse: () => null);

  Tool getByPosition(int index) =>
      (index < _tools.length && index >= 0) ? _tools[index] : null;
}
