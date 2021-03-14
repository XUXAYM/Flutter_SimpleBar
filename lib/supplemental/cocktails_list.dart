import 'package:flutter/material.dart';

import '../model/cocktail.dart';
import 'cocktail_card.dart';

class CocktailsList extends StatefulWidget {
  CocktailsList(this.cocktails);

  final List<Cocktail> cocktails;

  @override
  _CocktailsListState createState() => _CocktailsListState();
}

class _CocktailsListState extends State<CocktailsList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => CocktailCard(widget.cocktails[index]),
      itemCount: widget.cocktails.length,
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
      ),
      padding: EdgeInsets.all(16.0),
    );
  }
}
