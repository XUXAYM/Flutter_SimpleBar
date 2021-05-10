import 'package:flutter/material.dart';

import '../model/cocktail.dart';
import 'cocktail_card.dart';

class CocktailsList extends StatelessWidget {
  CocktailsList(this.cocktails);

  final List<Cocktail> cocktails;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => CocktailCard(cocktails[index]),
      itemCount: cocktails.length,
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: 16,
      ),
      padding: EdgeInsets.all(16.0),
    );
  }
}
