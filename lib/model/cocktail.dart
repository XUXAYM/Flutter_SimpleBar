import 'package:meta/meta.dart';
import 'ingredient.dart';
import 'tool.dart';

enum CocktailGroup {all, long, short, shot, hot, other}

class Cocktail {
  final int id;
  String title;
  String description;
  List<String> recipe;
  CocktailGroup group;
  String basis;
  int degree;
  int volume;
  List<Ingredient> ingredients;
  List<Tool> tools;
  String imageSource;

  Cocktail({
      @required this.id,
      @required this.title,
      this.description = '',
      this.recipe,
      this.group = CocktailGroup.other,
      @required this.ingredients,
      @required this.tools,
      this.imageSource}) : assert(id >= 0 && title.isNotEmpty && ingredients != null && tools != null);

  @override
  String toString() => "$title (id=$id)";
}