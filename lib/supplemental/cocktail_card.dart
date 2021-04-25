import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_cocktails_notifier.dart';
import '../page/cocktail_page.dart';
import '../model/cocktail.dart';
import '../constants.dart';

class CocktailCard extends StatelessWidget {
  CocktailCard(this.cocktail) : super(key: ObjectKey(cocktail));

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    bool isInFavorite = context.select<FavoriteCocktailsNotifier, bool>(
      (favorite) => favorite.cocktails.contains(cocktail),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: kBorderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          title: _TitleText(cocktail.title),
          trailing: IconButton(
              icon: isInFavorite
                  ? Icon(Icons.favorite_rounded)
                  : Icon(Icons.favorite_border_rounded),
              color: isInFavorite ? Colors.redAccent : null,
              onPressed: isInFavorite
                  ? () {
                      var favorite = context.read<FavoriteCocktailsNotifier>();
                      favorite.remove(cocktail);
                    }
                  : () {
                      var favorite = context.read<FavoriteCocktailsNotifier>();
                      favorite.add(cocktail);
                    }),
          backgroundColor: Colors.black45,
        ),
      ),
      child: Material(
        color: Theme.of(context).cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(kBorderRadius),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(top: 32.0, bottom: 64.0),
            child: Ink.image(
              image: NetworkImage(cocktail.imageSource),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CocktailPage(cocktail)));
          },
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  _TitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}
