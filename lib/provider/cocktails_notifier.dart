import 'package:flutter/foundation.dart';
import 'package:simplebar/model/repository/cocktails_repository.dart';
import '../model/cocktail.dart';

class CocktailsPoolNotifier with ChangeNotifier {
  final List<Cocktail> _cocktails =
      CocktailsRepository().loadCocktails(CocktailGroup.all);

  Cocktail getById(int id) =>
      _cocktails.firstWhere((c) => c.id == id, orElse: () => null);

  Cocktail getByPosition(int index) =>
      (index < _cocktails.length && index >= 0) ? _cocktails[index] : null;

  List<Cocktail> loadCocktails(CocktailGroup group) => group == CocktailGroup.all ?
  _cocktails : _cocktails.where((Cocktail c) => c.group == group).toList();

  CocktailGroup _group = CocktailGroup.all;

  CocktailGroup get group => _group;

  set group(CocktailGroup newGroup) {
    if (_group != newGroup) {
      _group = newGroup;
    }
    notifyListeners();
  }
}