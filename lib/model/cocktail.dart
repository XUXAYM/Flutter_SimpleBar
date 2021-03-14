import 'package:meta/meta.dart';
import 'ingredient.dart';
import 'tool.dart';

enum CocktailGroup { all, long, short, shot, hot, other }

class Cocktail {
  final int id;
  final String title;
  final String description;
  final List<String> recipe;
  final CocktailGroup group;
  Ingredient basis;
  int degree;
  int volume;
  final List<Ingredient> ingredients;
  final List<Tool> tools;
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
            tools != null);
  // {
  //   if (ingredients.length > 0) {
  //     this.volume = ingredients
  //         .map<double>((i) => i.getQuantityInMl())
  //         .fold<double>(0, (previousValue, element) => previousValue + element)
  //         .round();
  //     // this.basis = ingredients
  //     //     .where((element) => element.degree > 0)
  //     //     .fold<Ingredient>(
  //     //         ingredients.first,
  //     //         (previousValue, element) =>
  //     //             previousValue.getQuantityInMl() >= element.getQuantityInMl()
  //     //                 ? previousValue
  //     //                 : element);
  //   }
  // }

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Cocktail && other.id == id;
}
