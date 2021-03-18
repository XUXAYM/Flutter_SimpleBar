import 'package:flutter/foundation.dart';

import '../model/ingredient.dart';
import '../model/repository/ingredients_repository.dart';

class IngredientsPoolNotifier with ChangeNotifier {
  final List<Ingredient> _ingredients = IngredientsRepository.loadIngredients();

  List<Ingredient> loadIngredients(IngredientGroup group) =>
      group == IngredientGroup.all
          ? _ingredients
          : _ingredients.where((Ingredient i) => i.group == group).toList();

  Ingredient getById(int id) =>
      _ingredients.firstWhere((i) => i.id == id, orElse: () => null);

  Ingredient getByPosition(int index) =>
      (index < _ingredients.length && index >= 0) ? _ingredients[index] : null;
}
