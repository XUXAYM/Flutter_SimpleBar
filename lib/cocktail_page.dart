import 'package:flutter/material.dart';
import 'package:simplebar/model/cocktail.dart';
import 'page.dart';

class CocktailPage extends StatelessWidget with PageWithTitle {
  CocktailPage(this._cocktail) :
        assert(_cocktail != null),
        title = _cocktail.title;

  String title;
  final Cocktail _cocktail;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(_cocktail.title),
      ),
    );
  }
}