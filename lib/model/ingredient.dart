import 'package:meta/meta.dart';

enum IngredientMeasure {ml, cl, l, gr, dash, drop, pinch, tbsp, tsp, pcs, sugarcube, oz }

class Ingredient {
  final int id;
  final String title;
  double _volume;
  final String description;
  final int degree;
  final IngredientMeasure measure;
  final String imageSource;

  Ingredient({
    @required this.id,
    @required this.title,
    @required volume,
    this.description = '',
    this.degree = 0,
    this.measure = IngredientMeasure.ml,
    this.imageSource = '',
  }) : assert(id >= 0 && title.isNotEmpty && volume > 0.0)
  {
    setQuantity(volume);
  }

  void setQuantity(double value) => _volume = value;
  double getQuantity() => _volume;
  double getQuantityInMl() => _volume * _measuresToMl[measure];
  double getQuantityInOz() => (_volume * _measuresToMl[measure]) / _measuresToMl[IngredientMeasure.oz];

  @override
  String toString() => "$title (id=$id)";

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Ingredient && other.id == id;

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