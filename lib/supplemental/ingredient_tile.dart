import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/page/can_make_cocktails_page.dart';

import '../provider/my_bar_notifier.dart';
import '../model/ingredient.dart';
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

    bool isContainsAllIngredients(HashSet<int> subList, HashSet<int> list) =>
        subList.length == list.intersection(subList).length;

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
        onPressed: isInBar
            ? () {
                var added = context.read<MyBarNotifier>();
                added.remove(ingredient);
              }
            : () {
                var added = context.read<MyBarNotifier>();
                added.add(ingredient);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Ingredient added.'),
                  action: SnackBarAction(
                    label: 'Look to cocktails with my ingredients',
                    textColor: Colors.white,
                    onPressed: () async {
                      var snapshot = await FirebaseFirestore.instance
                          .collection('cocktail')
                          .get();
                      if (snapshot.docs.isEmpty) {
                        print('Empty');
                      } else {
                        HashSet<int> cocktailsId = HashSet();
                        for (var doc in snapshot.docs) {
                          var cocktailData = doc.data();
                          var ingredients = (cocktailData['ingredients'] as Map)
                              .keys
                              .map((id) => int.parse(id));

                          if (isContainsAllIngredients(
                              HashSet.from(ingredients),
                              added.ingredientsId.toSet())) {
                            cocktailsId.add(cocktailData['id']);
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CanMakeCocktailsPage(cocktailsId),
                            ));
                      }
                    },
                  ),
                ));
              },
      ),
    );
  }
}
