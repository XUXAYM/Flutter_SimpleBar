import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/my_bar_notifier.dart';
import '../model/ingredient.dart';
import '../constants.dart';
import 'circle_image.dart';

class IngredientListTile extends StatelessWidget {
  IngredientListTile(this.ingredient, {this.subtitle: ''})
      : assert(ingredient != null);

  final Ingredient ingredient;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    bool isInBar = context.select<MyBarNotifier, bool>(
      (myBar) => myBar.isHaveIngredient(ingredient.id),
    );

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
          isInBar ? Icons.clear : Icons.add,
        ),
        onPressed: () {
          var myBar = context.read<MyBarNotifier>();
          isInBar ? myBar.remove(ingredient) : myBar.add(ingredient);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(isInBar ? 'Ingredient removed' : 'Ingredient added'),
            action: SnackBarAction(
              label: 'Go to cocktails with my ingredients',
              textColor: kTitleGreyColor,
              onPressed: () => Navigator.pushNamed(context, '/can_make'),
            ),
          ));
        },
      ),
    );
  }
}
