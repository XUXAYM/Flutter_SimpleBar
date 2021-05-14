import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cocktail.dart';
import 'cocktails_notifier.dart';

const String kFavoriteCocktailsVariable = 'favorite_cocktails';

class FavoriteCocktailsNotifier extends ChangeNotifier {
  CocktailsPoolNotifier _cocktailsPool;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final HashSet<int> _favoriteCocktailsId = HashSet();

  FavoriteCocktailsNotifier(){
    _prefs.then((prefs){
      if(prefs.containsKey(kFavoriteCocktailsVariable)){
        _favoriteCocktailsId.addAll(prefs.getStringList(kFavoriteCocktailsVariable).map((e) => int.parse(e)));
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

  UnmodifiableSetView<int> get cocktailsId =>
      UnmodifiableSetView<int>(_favoriteCocktailsId);

  HashSet<Future<Cocktail>> get futureCocktails =>
      HashSet.of(_favoriteCocktailsId.map((id) => _cocktailsPool.getFutureById(id)));

  bool isFavorite(int id) => _favoriteCocktailsId.contains(id);

  void add(Cocktail cocktail) async {
    _favoriteCocktailsId.add(cocktail.id);
    notifyListeners();
    await _prefs..setStringList(kFavoriteCocktailsVariable, _favoriteCocktailsId.map<String>((id) => id.toString()).toList());
  }

  void remove(Cocktail cocktail) async{
    _favoriteCocktailsId.remove(cocktail.id);
    notifyListeners();
    await _prefs..setStringList(kFavoriteCocktailsVariable, _favoriteCocktailsId.map<String>((id) => id.toString()).toList());
  }
}