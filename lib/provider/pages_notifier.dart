import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../page/home.dart';
import '../page/my_bar_page.dart';
import '../page/category_menu_page.dart';
import '../page/cocktails_filter_page.dart';
import '../page/ingredients_list_page.dart';


class PagesPoolNotifier with ChangeNotifier{
  PagesPoolNotifier()
  {
    _currentFrontPage = _frontPages.first;
    _currentBackdropPage = _backPages.first;
  }
  List<Widget> _frontPages = [
    CocktailsListPage( title: 'Cocktails'),
    IngredientListPage( title: 'Ingredients'),
    TransitionsHomePage(title: 'Animation test',),
  ];

  static GlobalKey _backPageKey =  GlobalKey();

  List<Widget> _backPages = [
    CategoryMenuPage(key: _backPageKey,),
    CocktailsFilterPage(key: _backPageKey),
  ];

  Widget _currentFrontPage;
  Widget _currentBackdropPage;

  List<Widget> get frontPages => _frontPages;
  List<Widget> get backPages => _backPages;

  Widget get currentFrontPage => _currentFrontPage;
  set currentFrontPage(Widget value){
    if(_currentFrontPage != value){
      _currentFrontPage = value;
    }
    notifyListeners();
  }

  Widget get currentBackdropPage => _currentBackdropPage;
  set currentBackdropPage(Widget value){
    if(_currentBackdropPage != value){
      _currentBackdropPage = value;
      notifyListeners();
    }
  }
}