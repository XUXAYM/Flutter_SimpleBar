import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/provider/tools_notifier.dart';

import 'app.dart';
import 'provider/cocktails_notifier.dart';
import 'provider/favorite_cocktails_notifier.dart';
import 'provider/ingredients_notifier.dart';
import 'provider/pages_notifier.dart';

void main() => runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ToolsPoolNotifier()),
        ChangeNotifierProvider(create: (_) => IngredientsPoolNotifier()),
        ChangeNotifierProvider(create: (_) => CocktailsPoolNotifier()),
        ChangeNotifierProvider(create: (_) => PagesPoolNotifier()),
        ChangeNotifierProxyProvider<CocktailsPoolNotifier, FavoriteCocktailsNotifier>(
          create: (context) => FavoriteCocktailsNotifier(),
          update: (context, cocktailsPool, favorite) {
            if (favorite == null) throw ArgumentError.notNull('favorite');
            favorite.cocktailsPool = cocktailsPool;
            return favorite;
          },
        ),
      ], child: SimpleBarApp()),
    );
