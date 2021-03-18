import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/page/cocktail_page.dart';
import 'package:simplebar/provider/favorite_cocktails_notifier.dart';
import '../model/cocktail.dart';

class CocktailCard extends StatefulWidget {
  CocktailCard(this.cocktail);

  final Cocktail cocktail;

  @override
  _CocktailCardState createState() => _CocktailCardState();
}

class _CocktailCardState extends State<CocktailCard> {
  @override
  Widget build(BuildContext context) {
    bool isInFavorite = context.select<FavoriteCocktailsNotifier, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (favorite) => favorite.cocktails.contains(widget.cocktail),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(27.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          title: _TitleText(widget.cocktail.title),
          trailing: IconButton(
              icon: isInFavorite
                  ? Icon(Icons.favorite_rounded)
                  : Icon(Icons.favorite_border_rounded),
              color: isInFavorite ? Colors.redAccent : null,
              onPressed: isInFavorite
                  ? () {
                      var favorite = context.read<FavoriteCocktailsNotifier>();
                      favorite.remove(widget.cocktail);
                    }
                  : () {
                      var favorite = context.read<FavoriteCocktailsNotifier>();
                      favorite.add(widget.cocktail);
                    }),
          backgroundColor: Colors.black45,
        ),
      ),
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(27.0)),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Ink.image(
              image: NetworkImage(widget.cocktail.imageSource),
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CocktailPage(widget.cocktail)));
          },
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText(this.text);

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
