import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors.dart';
import '../supplemental/cocktails_list.dart';
import '../provider/favorite_cocktails_notifier.dart';

class FavoriteCocktailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var favoriteNotifier = context.watch<FavoriteCocktailsNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite cocktails'.toUpperCase(),
          style: Theme.of(context)
              .primaryTextTheme
              .headline6
              .copyWith(color: kShrinePink100),
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: kShrinePink100,
        backwardsCompatibility: false,
      ),
      body: favoriteNotifier.cocktails.isNotEmpty
          ? SafeArea(child: CocktailsList(favoriteNotifier.cocktails))
          : Center(child: Text('Sorry, favorite list is empty.')),
    );
  }
}
