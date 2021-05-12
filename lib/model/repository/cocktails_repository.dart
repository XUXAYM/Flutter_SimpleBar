import 'dart:collection';

import '../cocktail.dart';
import 'ingredients_repository.dart';
import 'tools_repository.dart';

class CocktailsRepository {
  final ingredients = IngredientsRepository.loadIngredients();
  final tools = ToolsRepository.loadTools();

  HashSet<Cocktail> loadCocktails() {
    var allCocktails = <Cocktail> [
      Cocktail(
        id: 0,
        title: 'Black Russian',
        imageSource: 'https://i.ibb.co/JmBMN9H/black-russian.jpg',
        recipe: [
          'Fill the rocks with ice cubes to the top',
          'Pour coffee liqueur 20 ml, vodka 50 ml',
          'Stir with a cocktail spoon'
        ],
        tools: HashMap.of({
          0:1,
          1:1,
          2:1,
        }),
        ingredients: HashMap.of({
          0: 50,
          1: 20,
        }),
        group: CocktailGroup.short,
      ),
      Cocktail(
        id: 1,
        title: 'White Russian',
        imageSource: 'https://i.ibb.co/cbMpY0M/white-russian.jpg',
        tools: HashMap.of({
          0:1,
          1:1,
          2:1,
        }),
        ingredients: HashMap.of({
          0: 50,
          1: 20,
          2: 20,
        }),
        group: CocktailGroup.short,
      ),
      Cocktail(
        id: 2,
        title: 'Cosmopolitan',
        imageSource: 'https://i.ibb.co/bbtZFJQ/cosmopolitan.jpg',
        tools: HashMap(),
        ingredients: HashMap(),
        group: CocktailGroup.long,
      ),
      Cocktail(
        id: 3,
        title: 'B-52',
        imageSource: 'https://i.ibb.co/KDPNZvH/b-52.jpg',
        tools: HashMap(),
        ingredients: HashMap(),
        group: CocktailGroup.shot,
      ),
    ];
    return HashSet.of(allCocktails);
  }
}