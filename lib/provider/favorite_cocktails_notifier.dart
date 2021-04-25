import 'dart:collection';

import 'package:flutter/material.dart';

import '../model/cocktail.dart';
import 'cocktails_notifier.dart';

class FavoriteCocktailsNotifier extends ChangeNotifier {
  CocktailsPoolNotifier _cocktailsPool;

  final List<int> _cocktailIds = [];

  CocktailsPoolNotifier get cocktailsPool => _cocktailsPool;

  set cocktailsPool(CocktailsPoolNotifier newCocktailsPool) {
    _cocktailsPool = newCocktailsPool;
    notifyListeners();
  }

  UnmodifiableListView<Cocktail> get cocktails =>
      UnmodifiableListView<Cocktail>(_cocktailIds.map((id) => _cocktailsPool.getById(id)));

  void add(Cocktail cocktail) {
    _cocktailIds.add(cocktail.id);
    notifyListeners();
  }

  void remove(Cocktail cocktail) {
    _cocktailIds.remove(cocktail.id);
    notifyListeners();
  }
}