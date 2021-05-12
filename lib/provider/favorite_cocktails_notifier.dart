import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cocktail.dart';
import 'cocktails_notifier.dart';

const String kFavoriteCocktailsVariable = 'favorite_cocktails';

class FavoriteCocktailsNotifier extends ChangeNotifier {
  CocktailsPoolNotifier _cocktailsPool;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final HashSet<int> _cocktailsId = HashSet();

  FavoriteCocktailsNotifier(){
    _prefs.then((prefs){
      if(prefs.containsKey(kFavoriteCocktailsVariable)){
        _cocktailsId.addAll(prefs.getStringList(kFavoriteCocktailsVariable).map((e) => int.parse(e)));
        notifyListeners();
      }
      else
        prefs.setStringList(kFavoriteCocktailsVariable, []);
    });
  }

  CocktailsPoolNotifier get cocktailsPool => _cocktailsPool;

  set cocktailsPool(CocktailsPoolNotifier newCocktailsPool) {
    _cocktailsPool = newCocktailsPool;
    notifyListeners();
  }

  UnmodifiableSetView<Cocktail> get cocktails =>
      UnmodifiableSetView<Cocktail>(_cocktailsId.map((id) => _cocktailsPool.getById(id)));

  HashSet<Future<Cocktail>> get futureCocktails =>
      HashSet.of(_cocktailsId.map((id) => _cocktailsPool.getFutureById(id)));

  bool isFavorite(int id) => _cocktailsId.contains(id);

  void add(Cocktail cocktail) async {
    _cocktailsId.add(cocktail.id);
    notifyListeners();
    await _prefs..setStringList(kFavoriteCocktailsVariable, _cocktailsId.map<String>((id) => id.toString()).toList());
  }

  void remove(Cocktail cocktail) async{
    _cocktailsId.remove(cocktail.id);
    notifyListeners();
    await _prefs..setStringList(kFavoriteCocktailsVariable, _cocktailsId.map<String>((id) => id.toString()).toList());
  }
}