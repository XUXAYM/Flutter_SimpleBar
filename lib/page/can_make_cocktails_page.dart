import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cocktail.dart';
import '../provider/my_bar_notifier.dart';
import '../provider/cocktails_notifier.dart';
import '../supplemental/cocktail_card.dart';
import '../constants.dart';

class CanMakeCocktailsPage extends StatelessWidget {
  CanMakeCocktailsPage();

  @override
  Widget build(BuildContext context) {
    var cocktailsNotifier = context.watch<CocktailsPoolNotifier>();
    var myBar = context.watch<MyBarNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cocktails'.toUpperCase(),
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
      body: myBar.cocktailsId.isNotEmpty
          ? SafeArea(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 16,
              ),
              physics: BouncingScrollPhysics(),
              controller: ScrollController(),
              padding: EdgeInsets.all(16.0),
              itemCount: myBar.cocktailsId.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: cocktailsNotifier.getFutureById(myBar.cocktailsId.elementAt(index)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(
                          'Cocktail ${(snapshot.data as Cocktail).title}, id ${(snapshot.data as Cocktail).id}');
                      return CocktailCard(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }))
          : Center(child: Text('Sorry, you can\'t make anything.')),
    );
  }
}