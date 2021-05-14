import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ingredient.dart';
import 'ingredients_notifier.dart';

const String kMyBarIngredientsVariable = 'bar_ingredients';

class MyBarNotifier extends ChangeNotifier {
  IngredientsPoolNotifier _ingredientsPool;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final HashSet<int> _ingredientsId = HashSet();
  final HashSet<int> _cocktailsId = HashSet();

  MyBarNotifier() {
    _prefs.then((prefs) {
      if (prefs.containsKey(kMyBarIngredientsVariable)) {
        _ingredientsId.addAll(prefs
            .getStringList(kMyBarIngredientsVariable)
            .map((e) => int.parse(e)));
        notifyListeners();
      } else
        prefs.setStringList(kMyBarIngredientsVariable, []);
    });
    findCocktailsWithMyIngredients();
  }

  IngredientsPoolNotifier get ingredientsPool => _ingredientsPool;

  UnmodifiableSetView<int> get ingredientsId =>
      UnmodifiableSetView<int>(_ingredientsId);

  UnmodifiableSetView<int> get cocktailsId =>
      UnmodifiableSetView<int>(_cocktailsId);

  bool isContainsAllIngredients(HashSet<int> subList) =>
      subList.length == ingredientsId.intersection(subList).length;

  Future<void> findCocktailsWithMyIngredients() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('cocktail').get();
    _cocktailsId.clear();
    if (snapshot.docs.isEmpty) {
      print('Empty');
    } else {
      for (var doc in snapshot.docs) {
        var cocktailData = doc.data();
        var ingredients = (cocktailData['ingredients'] as Map)
            .keys
            .map((id) => int.parse(id));

        if (isContainsAllIngredients(HashSet.from(ingredients))) {
          _cocktailsId.add(cocktailData['id']);
        }
      }
    }
    print('Ready');
    notifyListeners();
  }

  set ingredientsPool(IngredientsPoolNotifier newIngredientsPool) {
    _ingredientsPool = newIngredientsPool;
    notifyListeners();
  }

  bool isHaveIngredient(int id) => _ingredientsId.contains(id);

  void add(Ingredient ingredient) async {
    _ingredientsId.add(ingredient.id);
    notifyListeners();
    await findCocktailsWithMyIngredients();
    await _prefs
      ..setStringList(kMyBarIngredientsVariable,
          _ingredientsId.map<String>((e) => e.toString()).toList());
  }

  void remove(Ingredient ingredient) async {
    _ingredientsId.remove(ingredient.id);
    notifyListeners();
    await findCocktailsWithMyIngredients();
    await _prefs
      ..setStringList(kMyBarIngredientsVariable,
          _ingredientsId.map<String>((e) => e.toString()).toList());
  }
}
