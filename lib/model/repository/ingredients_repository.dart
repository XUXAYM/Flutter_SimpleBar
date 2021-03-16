import '../ingredient.dart';

class IngredientsRepository {
  static List<Ingredient> loadIngredients() {
    var allIngredients = <Ingredient>[
      Ingredient(
        id: 0,
        title: 'Vodka',
        volume: 50.0,
        degree: 40,
        group: IngredientGroup.hard_spirit,
        imageSource: 'https://i.ibb.co/B4R1Rw6/vodka.jpg',
      ),
      Ingredient(
        id: 1,
        title: 'Coffee Liqueur',
        volume: 20.0,
        degree: 24,
        group: IngredientGroup.liqueur,
        imageSource: 'https://i.ibb.co/H4wDLdB/coffee-liqueur.jpg',
      ),
      Ingredient(
        id: 2,
        title: 'Сream',
        volume: 20.0,
        group: IngredientGroup.dairy,
        imageSource: 'https://i.ibb.co/pvcTFdr/heavy-cream.jpg',
      ),
    ];
    return allIngredients.toList();
  }


  static getById(int id) =>
      loadIngredients().singleWhere((ingredient) => ingredient.id == id);
}
