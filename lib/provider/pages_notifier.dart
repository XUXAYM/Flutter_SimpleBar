import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simplebar/model/cocktail.dart';
import 'package:simplebar/model/repository/cocktails_repository.dart';

import '../cocktail_page.dart';
import '../home.dart';
import '../ingredients_list_page.dart';

class PagesPoolNotifier with ChangeNotifier{
  PagesPoolNotifier() {_currentPage = _pages.first;}
  List<Widget> _pages = [
    CocktailsListPage( title: 'Cocktails'),
    IngredientListPage( title: 'Ingredients'),
    CocktailPage(CocktailsRepository().loadCocktails(CocktailGroup.all)[0]),
  ];

  Widget _currentPage;

  List<Widget> get pages => _pages;

  Widget get currentPage => _currentPage;
  set currentPage(Widget value){
    if(_currentPage != value){
      _currentPage = value;
      notifyListeners();
    }
  }
}