import 'package:flutter/material.dart';
import '../model/cocktail.dart';

class CocktailCard extends StatefulWidget {
  CocktailCard(this.cocktail);

  final Cocktail cocktail;



  @override
  _CocktailCardState createState() => _CocktailCardState();
}

class _CocktailCardState extends State<CocktailCard> {
  bool alreadySaved = false;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.0)),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          title: _TitleText(widget.cocktail.title),
          trailing: IconButton(
            icon: alreadySaved ? Icon(Icons.favorite_rounded) : Icon(Icons.favorite_border_rounded),
            color: alreadySaved ? Colors.redAccent : null,
            onPressed: () {
              setState(() {
                alreadySaved = !alreadySaved;
              });
            },
          ),
          backgroundColor: Colors.black45,
        ),
      ),
      child: Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Ink.image(image: NetworkImage(widget.cocktail.imageSource)),
          ),
          onTap: () {
            print('Card tapped.');
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
