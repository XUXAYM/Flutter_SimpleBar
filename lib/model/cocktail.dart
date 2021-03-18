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
            tools != null)
  {
    volume = ingredients.length > 0 ? ingredients.values.fold(0, (sum, volume) => sum += volume) : 0;
  }

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Cocktail && other.id == id;
}
