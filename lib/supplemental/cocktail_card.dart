import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_cocktails_notifier.dart';
import '../page/cocktail_page.dart';
import '../model/cocktail.dart';
import '../constants.dart';
import 'title_text.dart';

class CocktailCard extends StatelessWidget {
  CocktailCard(this.cocktail) : super(key: ObjectKey(cocktail));

  final Cocktail cocktail;

  @override
  Widget build(BuildContext context) {
    bool isInFavorite = context.select<FavoriteCocktailsNotifier, bool>(
      (favorite) => favorite.isFavorite(cocktail.id),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: kBorderRadius),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          title: TitleText(cocktail.title),
          trailing: IconButton(
              icon: isInFavorite
                  ? Icon(Icons.favorite_rounded)
                  : Icon(Icons.favorite_border_rounded),
              color: isInFavorite ? Colors.redAccent : null,
              onPressed: () {
                var favorite = context.read<FavoriteCocktailsNotifier>();
                isInFavorite
                    ? favorite.remove(cocktail)
                    : favorite.add(cocktail);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(isInFavorite ?  'Cocktail removed' : 'Cocktail added'),
                  action: SnackBarAction(
                    label: 'Go to favorite',
                    textColor: kTitleGreyColor,
                    onPressed: () => Navigator.pushNamed(context, '/favorite'),
                  ),
                ));
              }),
          backgroundColor: Colors.black45,
        ),
      ),
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(kBorderRadius),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.only(
                top: 32.0, bottom: 64.0, left: 32.0, right: 32.0),
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
