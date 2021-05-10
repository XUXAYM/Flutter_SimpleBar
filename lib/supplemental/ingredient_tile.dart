import 'package:flutter/material.dart';
import '../model/ingredient.dart';
import 'circle_image.dart';

class IngredientListTile extends StatelessWidget {
  IngredientListTile(this.ingredient, {this.subtitle: ''})
      : assert(ingredient != null);

  final Ingredient ingredient;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExcludeSemantics(
        child: CircleImage(src: ingredient.imageSource),
      ),
      title: Text(ingredient.title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        tooltip: 'Add to my bar',
        alignment: Alignment.center,
        icon: Icon(
          Icons.add,
        ),
        onPressed: () {},
      ),
    );
  }
}
