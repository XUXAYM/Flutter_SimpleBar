import 'package:flutter/material.dart';

import 'page.dart';

class IngredientListPage extends StatelessWidget with PageWithTitle {
  IngredientListPage({this.title: ''});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('IngredientListPage'));

  }
}