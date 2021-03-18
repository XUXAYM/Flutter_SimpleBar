import 'package:flutter/material.dart';

import '../model/ingredient.dart';
import 'ingredient_tile.dart';

class IngredientsList extends StatefulWidget {
  IngredientsList(this.ingredients);

  final List<Ingredient> ingredients;

  @override
  _IngredientsListState createState() => _IngredientsListState();
}

class _IngredientsListState extends State<IngredientsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.ingredients.length,
      itemBuilder: (context, index) {
        Ingredient ingredient = widget.ingredients[index];
        return IngredientListTile(ingredient,
            subtitle: "Degree: " + ingredient.degree.toString());
      },
    );
  }
}
