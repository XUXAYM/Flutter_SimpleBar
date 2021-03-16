import 'package:flutter/foundation.dart';

import '../model/ingredient.dart';
import '../model/repository/ingredients_repository.dart';

class IngredientsPoolNotifier with ChangeNotifier {
  final List<Ingredient> _ingredient = IngredientsRepository.loadIngredients();

  List<Ingredient> loadIngredients(IngredientGroup group) =>
      group == IngredientGroup.all
          ? _ingredient
          : _ingredient.where((Ingredient i) => i.group == group).toList();

  Ingredient getById(int id) =>
      _ingredient.firstWhere((c) => c.id == id, orElse: () => null);

  Ingredient getByPosition(int index) =>
      (index < _ingredient.length && index >= 0) ? _ingredient[index] : null;

// List<Ingredient> loadCocktails(CocktailGroup group) => group == CocktailGroup.all ?
// _ingredient : _ingredient.where((Ingredient c) => c.group == group).toList();

//CocktailGroup _group = CocktailGroup.all;

//CocktailGroup get group => _group;
}
