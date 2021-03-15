import 'package:flutter/foundation.dart';

import '../model/cocktail.dart';
import 'cocktails_notifier.dart';

class FavoriteCocktailsNotifier extends ChangeNotifier {
  /// The private field backing [catalog].
  //late
  CocktailsPoolNotifier _cocktailsPool;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _cocktailIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CocktailsPoolNotifier get cocktailsPool => _cocktailsPool;

  set cocktailsPool(CocktailsPoolNotifier newCocktailsPool) {
    _cocktailsPool = newCocktailsPool;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Cocktail> get cocktails => _cocktailIds.map((id) => _cocktailsPool.getById(id)).toList();

  /// The current total price of all items.

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Cocktail cocktail) {
    _cocktailIds.add(cocktail.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Cocktail cocktail) {
    _cocktailIds.remove(cocktail.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}