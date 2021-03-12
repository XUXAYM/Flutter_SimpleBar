import 'package:flutter/foundation.dart';
import '../model/cocktail.dart';

class CocktailsNotifier with ChangeNotifier{
  CocktailGroup _group = CocktailGroup.all;

  CocktailGroup get group => _group;

  set group(CocktailGroup newGroup){
    if(_group != newGroup){
      _group = newGroup;
    }
    notifyListeners();
  }
}