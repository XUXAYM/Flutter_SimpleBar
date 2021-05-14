import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_cocktails_notifier.dart';
import '../provider/my_bar_notifier.dart';
import '../supplemental/info_block_card.dart';
import '../supplemental/info_tile.dart';

import 'page.dart';

class MyBarPage extends StatefulWidget with PageWithTitle {
  MyBarPage({this.title: ''}) : assert(title != null);

  final String title;

  @override
  _MyBarPageState createState() => _MyBarPageState();
}

class _MyBarPageState extends State<MyBarPage> {
  @override
  Widget build(BuildContext context) {
    final myBarData = Provider.of<MyBarNotifier>(context);
    final favoriteCocktailsData =
        Provider.of<FavoriteCocktailsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InfoBlockCard(
          children: [
            InfoListTile(
              title: 'My ingredients',
              value: myBarData.ingredientsId.length,
            ),
          ],
        ),
        InfoBlockCard(
          children: [
            GestureDetector(
              child: InfoListTile(
                title: 'Favorite cocktails',
                value: favoriteCocktailsData.cocktailsId.length,
              ),
              onTap: () => Navigator.pushNamed(context, '/favorite'),
            ),
            GestureDetector(
              child: InfoListTile(
                title: 'Cocktails with my ingredients',
                value: myBarData.cocktailsId.length,
              ),
              onTap: () => Navigator.pushNamed(context, '/can_make'),
            ),
            InfoListTile(
              title: 'My cocktails',
              value: '0',
            ),
          ],
        ),
      ],
    );
  }
}
