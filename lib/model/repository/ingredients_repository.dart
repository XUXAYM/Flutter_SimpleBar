import '../ingredient.dart';

class IngredientsRepository {
  static List<Ingredient> loadIngredients() {
    var allIngredients = <Ingredient>[
      Ingredient(
        id: 0,
        title: 'Vodka',
        degree: 40,
        group: IngredientGroup.hard_spirit,
        imageSource: 'https://i.ibb.co/B4R1Rw6/vodka.jpg',
      ),
      Ingredient(
        id: 1,
        title: 'Coffee Liqueur',
        degree: 24,
        group: IngredientGroup.liqueur,
        imageSource: 'https://i.ibb.co/H4wDLdB/coffee-liqueur.jpg',
      ),
      Ingredient(
        id: 2,
        title: 'Сream',
        group: IngredientGroup.dairy,
        imageSource: 'https://i.ibb.co/pvcTFdr/heavy-cream.jpg',
      ),
      Ingredient(
        id: 3,
        title: 'White rum',
        degree: 40,
        group: IngredientGroup.hard_spirit,
        imageSource: 'https://i.ibb.co/SKYL6Cq/white-rum.jpg',
      ),
      Ingredient(
        id: 4,
        title: 'Bourbon',
        degree: 40,
        group: IngredientGroup.hard_spirit,
        imageSource: 'https://i.ibb.co/VVh2L6Z/bourbon.jpg',
      ),
    ];
    return allIngredients.toList();
  }


  static getById(int id) =>
      loadIngredients().singleWhere((ingredient) => ingredient.id == id);
}
