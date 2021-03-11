import '../tool.dart';
import '../cocktail.dart';
import 'ingredients_repository.dart';
import 'tools_repository.dart';

class CocktailsRepository {
  final ingredients = IngredientsRepository.loadIngredients();
  final tools = ToolsRepository.loadTools(ToolType.all);

  List<Cocktail> loadCocktails(CocktailGroup group) {
    var allCocktails = <Cocktail> [
      Cocktail(
        id: 0,
        title: 'Black Russian',
        imageSource: 'https://i.ibb.co/JmBMN9H/black-russian.jpg',
        tools: tools,
        ingredients: [
          IngredientsRepository.getById(0),
          IngredientsRepository.getById(1),
        ],
        group: CocktailGroup.short,
      ),
      Cocktail(
        id: 1,
        title: 'White Russian',
        imageSource: 'https://i.ibb.co/cbMpY0M/white-russian.jpg',
        tools: tools,
        ingredients: [
          IngredientsRepository.getById(0),
          IngredientsRepository.getById(1),
          IngredientsRepository.getById(2),
        ],
        group: CocktailGroup.short,
      ),
      Cocktail(
        id: 2,
        title: 'Cosmopolitan',
        imageSource: 'https://i.ibb.co/bbtZFJQ/cosmopolitan.jpg',
        tools: [],
        ingredients: [],
        group: CocktailGroup.long,
      ),
      Cocktail(
        id: 3,
        title: 'B-52',
        imageSource: 'https://i.ibb.co/KDPNZvH/b-52.jpg',
        tools: [],
        ingredients: [],
        group: CocktailGroup.shot,
      ),
    ];
    if (group == CocktailGroup.all) {
      return allCocktails;
    } else {
      return allCocktails.where((Cocktail c) {
        return c.group == group;
      }).toList();
    }
  }
}