import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/tool.dart';
import '../model/repository/tools_repository.dart';

String langCode = 'ru';
const String collectionName = 'tool';
const String subCollectionName = 'locale';

class ToolsPoolNotifier with ChangeNotifier {
  final HashSet<Tool> _tools = ToolsRepository.loadTools();
  final collection = FirebaseFirestore.instance.collection(collectionName);

  HashSet<Tool> loadIngredients() => _tools;

  Future<Tool> getFutureById(int id) async{
    var snapshot = await collection.where('id', isEqualTo: id).get();
    var doc = snapshot.docs[0];
    var mappedToolData = doc.data();
    var localeDataSnapshot = doc.reference.collection(subCollectionName).doc('ru');
    var localeData = await localeDataSnapshot.get();
    mappedToolData.addAll( localeData.data());

    return Tool.fromMap(mappedToolData);
  }

  Tool getById(int id) =>
      _tools.firstWhere((t) => t.id == id, orElse: () => null);
}
