import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/repository/cocktails_repository.dart';
import '../page/cocktail_page.dart';
import '../page/home.dart';
import '../page/ingredients_list_page.dart';

class PagesPoolNotifier with ChangeNotifier{
  PagesPoolNotifier() {_currentPage = _pages.first;}
  List<Widget> _pages = [
    CocktailsListPage( title: 'Cocktails'),
    IngredientListPage( title: 'Ingredients'),
    CocktailPage(CocktailsRepository().loadCocktails()[0]),
  ];

  Widget _currentPage;

  List<Widget> get pages => _pages;

  Widget get currentPage => _currentPage;
  set currentPage(Widget value){
    if(_currentPage != value){
      _currentPage = value;
    }
    notifyListeners();
  }
}