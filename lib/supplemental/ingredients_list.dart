import 'package:flutter/material.dart';

import '../model/ingredient.dart';
import 'ingredient_tile.dart';

class IngredientsList extends StatelessWidget {
  IngredientsList(this.ingredients);

  final List<Ingredient> ingredients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        Ingredient ingredient = ingredients[index];
        return IngredientListTile(ingredient,
            subtitle: "Degree: " + ingredient.degree.toString());
      },
    );
  }
}
