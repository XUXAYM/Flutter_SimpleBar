import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page.dart';
import '../provider/cocktails_notifier.dart';
import '../supplemental/cocktails_list.dart';

class CocktailsListPage extends StatelessWidget with PageWithTitle {
  CocktailsListPage({this.title: ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    var cocktailsNotifier = context.watch<CocktailsPoolNotifier>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: cocktailsNotifier.loadCocktails(cocktailsNotifier.group).isNotEmpty
          ? SafeArea(
              child: CocktailsList(
                cocktailsNotifier.loadCocktails(cocktailsNotifier.group),
              ),
            )
          : Center(
              child: Text('Sorry, but list is empty.'),
            ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        child: Icon(Icons.local_bar_rounded),
        onPressed: () => Navigator.pushNamed(context, '/favorite'),
        backgroundColor: Theme.of(context).accentColor,
        tooltip: 'Favorite cocktails',
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
