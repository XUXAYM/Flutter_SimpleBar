import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

enum CocktailGroup { all, long, short, shot, hot, other }

class Cocktail {
  final int id;
  final String title;
  final String description;
  final List<String> recipe;
  final CocktailGroup group;
  int basis;
  int degree;
  int volume;
  final Map<int, int> ingredients;
  final Map<int, int> tools;
  final String imageSource;

  Cocktail({
    @required this.id,
    @required this.title,
    this.description: '',
    this.recipe,
    this.group = CocktailGroup.other,
    @required this.ingredients,
    @required this.tools,
    this.imageSource: '',
  }) : assert(id >= 0 &&
            title.isNotEmpty &&
            ingredients != null &&
            tools != null) {
    if(ingredients.length > 0){
      volume =  ingredients.values.fold(0, (sum, volume) => sum += volume);
    }
  }

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Cocktail && other.id == id;

  static Cocktail fromMap(Map mapCocktail) => Cocktail(
        id: mapCocktail['id'],
        title: mapCocktail['title'],
        description: mapCocktail['description'],
        imageSource: mapCocktail['imageSource'],
        ingredients: mapCocktail['ingredients'],
        tools: mapCocktail['tools'],
        recipe: (mapCocktail['recipe'] as List).map<String>((e) => e.toString()).toList(),
        group: CocktailGroup.values
            .firstWhere((e) => describeEnum(e) == mapCocktail['group']),
      );

  static Map toMap(Cocktail cocktail) => {
        'id': cocktail.id,
        'title': cocktail.title,
        'description': cocktail.description,
        'imageSource': cocktail.imageSource,
        'ingredients': cocktail.ingredients,
        'tools': cocktail.tools,
        'recipe': cocktail.recipe,
        'group': describeEnum(cocktail.group),
        // 'degree': cocktail.degree,
        // 'basis': cocktail.basis,
        // 'volume': cocktail.volume,
      };
}
