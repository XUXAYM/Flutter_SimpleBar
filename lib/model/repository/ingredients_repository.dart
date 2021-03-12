import '../ingredient.dart';

class IngredientsRepository {
  static List<Ingredient> loadIngredients() {
    var allIngredients = <Ingredient>[
      Ingredient(
        id: 0,
        title: 'Vodka',
        volume: 50.0,
        degree: 40,
      ),
      Ingredient(
        id: 1,
        title: 'Coffee Liqueur',
        volume: 20.0,
        degree: 24,
      ),
      Ingredient(
        id: 2,
        title: 'Сream',
        volume: 20.0,
      ),
    ];
    return allIngredients.toList();
  }

  static getById(int id) =>
      loadIngredients().singleWhere((ingredient) => ingredient.id == id);
}
