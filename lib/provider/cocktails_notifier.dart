import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../model/repository/cocktails_repository.dart';
import '../model/cocktail.dart';

String langCode = 'ru';
String collectionName = 'cocktail';
String subCollectionName = 'locale';

class CocktailsPoolNotifier with ChangeNotifier {
  final List<Cocktail> _cocktails = CocktailsRepository().loadCocktails();
  final collection = FirebaseFirestore.instance.collection(collectionName);

  Cocktail getById(int id) =>
      _cocktails.firstWhere((c) => c.id == id, orElse: () => null);

  Cocktail getByPosition(int index) =>
      (index < _cocktails.length && index >= 0) ? _cocktails[index] : null;

  List<Cocktail> loadCocktails(CocktailGroup group) =>
      group == CocktailGroup.all
          ? _cocktails
          : _cocktails.where((Cocktail c) => c.group == group).toList();

  Stream<QuerySnapshot> cocktailsGroupStream(CocktailGroup group) => group ==
          CocktailGroup.all
      ? collection.snapshots()
      : collection.where('group', isEqualTo: describeEnum(group)).snapshots();

  int get minDegree => loadCocktails(_group).map<int>((c) => c.degree).fold(
      100,
      (previousValue, element) => previousValue =
          previousValue > (element ?? 100) ? element : previousValue);

  int get maxDegree => loadCocktails(_group).map<int>((c) => c.degree).fold(
      0,
      (previousValue, element) => previousValue =
          previousValue < (element ?? 0) ? element : previousValue);

  CocktailGroup _group = CocktailGroup.all;

  CocktailGroup get group => _group;

  set group(CocktailGroup newGroup) {
    if (_group != newGroup) {
      _group = newGroup;
    }
    notifyListeners();
  }
}
