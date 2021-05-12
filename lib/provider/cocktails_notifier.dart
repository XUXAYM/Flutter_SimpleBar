import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/repository/cocktails_repository.dart';
import '../model/cocktail.dart';

const String langCode = 'ru';
const String collectionName = 'cocktail';
const String subCollectionName = 'locale';

class CocktailsPoolNotifier with ChangeNotifier {
  final HashSet<Cocktail> _cocktails = CocktailsRepository().loadCocktails();
  final collection = FirebaseFirestore.instance.collection(collectionName);

  Cocktail getById(int id) =>
      _cocktails.firstWhere((c) => c.id == id, orElse: () => null);

  Future<Cocktail> getFutureById(int id) async{
    var snapshot = await collection.where('id', isEqualTo: id).get();
    var doc = snapshot.docs[0];
    var cocktailMappedData = doc.data();
    var localeDataSnapshot = doc.reference.collection(subCollectionName).doc(langCode);
    var localeData = await localeDataSnapshot.get();
    cocktailMappedData['tools'] = HashMap.of((cocktailMappedData['tools'] as Map).map<int, int>((key, value) => MapEntry(int.parse(key), value)));
    cocktailMappedData['ingredients'] = HashMap.of((cocktailMappedData['ingredients'] as Map).map<int, int>((key, value) => MapEntry(int.parse(key), value)));
    cocktailMappedData.addAll( localeData.data());
    return Cocktail.fromMap(cocktailMappedData);
  }

  Stream<QuerySnapshot> cocktailsGroupStream(CocktailGroup group) => group ==
          CocktailGroup.all
      ? collection.snapshots()
      : collection.where('group', isEqualTo: describeEnum(group)).snapshots();

  CocktailGroup _group = CocktailGroup.all;

  CocktailGroup get group => _group;

  set group(CocktailGroup newGroup) {
    if (_group != newGroup) {
      _group = newGroup;
    }
    notifyListeners();
  }
}
