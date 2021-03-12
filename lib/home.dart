import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/repository/cocktails_repository.dart';
import 'page.dart';
import 'provider/cocktails_notifier.dart';
import 'supplemental/cocktails_list.dart';

class CocktailsListPage extends StatelessWidget with PageWithTitle{
  CocktailsListPage({this.title: ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CocktailsPoolNotifier>(
        builder: (context, notifier, _)
        => CocktailsList(CocktailsRepository().loadCocktails(notifier.group)),
      ),
    );
  }
}
