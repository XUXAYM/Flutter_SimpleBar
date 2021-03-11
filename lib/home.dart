import 'package:flutter/material.dart';
import 'model/cocktail.dart';
import 'model/repository/cocktails_repository.dart';
import 'supplemental/cocktail_card.dart';
import 'supplemental/cocktails_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.group: CocktailGroup.all});

  final CocktailGroup group;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: CocktailsList(CocktailsRepository().loadCocktails(group)),
    );
  }
}
