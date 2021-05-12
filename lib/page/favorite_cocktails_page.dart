import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/supplemental/cocktail_card.dart';

import '../constants.dart';
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
        foregroundColor: Theme.of(context).primaryColor,
        backwardsCompatibility: false,
      ),
      body: favoriteNotifier.futureCocktails.isNotEmpty
          ? SafeArea(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 16,
                  ),
                  physics: BouncingScrollPhysics(),
                  controller: ScrollController(),
                  padding: EdgeInsets.all(16.0),
                  itemCount: favoriteNotifier.futureCocktails.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: favoriteNotifier.futureCocktails.elementAt(index),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return CocktailCard(snapshot.data);
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    );
                  }))
          : Center(child: Text('Sorry, favorite list is empty.')),
    );
  }
}
