import 'package:flutter/material.dart';

import '../model/ingredient.dart';

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
        return ListTile(
          leading: ExcludeSemantics(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                  ingredient.imageSource,
                ),
              ),
              radius: 30,
            ),
          ),
          title: Text(ingredient.title),
          subtitle: Text("Degree: " + ingredient.degree.toString()),
        );
      },
    );
  }
}
