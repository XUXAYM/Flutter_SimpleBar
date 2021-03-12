import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/repository/cocktails_repository.dart';
import 'provider/cocktails_notifier.dart';
import 'supplemental/cocktails_list.dart';

class CocktailsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CocktailsNotifier>(
        builder: (context, notifier, _)
        => CocktailsList(CocktailsRepository().loadCocktails(notifier.group)),
      ),
    );
  }
}
