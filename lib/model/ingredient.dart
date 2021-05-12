import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

enum IngredientMeasure {
  ml,
  cl,
  l,
  gr,
  dash,
  drop,
  pinch,
  tbsp,
  tsp,
  pcs,
  sugarcube,
  oz
}
enum IngredientGroup {
  all,
  hard_spirit,
  vermouth,
  liqueur,
  bitter,
  wine,
  beer,
  syrup,
  juice,
  drink,
  tincture,
  tea,
  coffee,
  puree,
  jam,
  fruit,
  berry,
  vegetable,
  herb,
  dairy,
  eggs,
  sauce,
  oil,
  spice,
  ice,
  garnish,
  other
}

class Ingredient {
  final int id;
  final String title;
  final String description;
  final IngredientGroup group;
  final int degree;
  final IngredientMeasure measure;
  final String imageSource;

  Ingredient({
    @required this.id,
    @required this.title,
    this.description = '',
    this.group = IngredientGroup.other,
    this.degree = 0,
    this.measure = IngredientMeasure.ml,
    this.imageSource = '',
  }) : assert(id >= 0 && title.isNotEmpty);

  double getQuantityInMl(double volume) => volume * _measuresToMl[measure];

  double getQuantityInOz(double volume) =>
      (volume * _measuresToMl[measure]) / _measuresToMl[IngredientMeasure.oz];

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Ingredient && other.id == id;

  static Ingredient fromMap(Map mapIngredient) => Ingredient(
    id: mapIngredient['id'],
    title: mapIngredient['title'],
    description: mapIngredient['description'],
    imageSource: mapIngredient['imageSource'],
    degree: mapIngredient['degree'],
    group: IngredientGroup.values
        .firstWhere((e) => describeEnum(e) == mapIngredient['group']),
    measure: IngredientMeasure.values
        .firstWhere((e) => describeEnum(e) == mapIngredient['measure']),
  );

  static Map toMap(Ingredient ingredient) => {
    'id': ingredient.id,
    'title': ingredient.title,
    'description': ingredient.description,
    'imageSource': ingredient.imageSource,
    'degree': ingredient.degree,
    'group': describeEnum(ingredient.group),
    'measure': describeEnum(ingredient.measure),
  };

  static const Map<IngredientMeasure, double> _measuresToMl = {
    IngredientMeasure.cl: 10,
    IngredientMeasure.dash: 0.462086,
    IngredientMeasure.drop: 0.05,
    IngredientMeasure.gr: 1.0905,
    IngredientMeasure.ml: 1,
    IngredientMeasure.l: 1000,
    IngredientMeasure.oz: 29.37,
    IngredientMeasure.pcs: 0,
    IngredientMeasure.pinch: 0.231043,
    IngredientMeasure.tbsp: 14.78,
    IngredientMeasure.tsp: 4.9,
    IngredientMeasure.sugarcube: 7.8636,
  };
}
