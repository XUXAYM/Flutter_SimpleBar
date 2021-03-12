import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cocktail.dart';
import '../provider/cocktails_notifier.dart';
import '../colors.dart';

class CocktailGroupDropdownButton extends StatefulWidget {
  @override
  _CocktailGroupDropdownButton createState() => _CocktailGroupDropdownButton();
}

class _CocktailGroupDropdownButton extends State<CocktailGroupDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<CocktailsPoolNotifier>(context);
    final ThemeData theme = Theme.of(context);
    return DropdownButton<CocktailGroup>(
      value: _notifier.group,
      onChanged: (CocktailGroup value) => _notifier.group = value,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: kShrineBrown900,
      ),
      iconSize: 24,
      elevation: 16,
      style: theme.textTheme.bodyText1.copyWith(color: kShrineBrown900),
      underline: Container(
        height: 2,
        color: kShrineBrown900,
      ),
      items: CocktailGroup.values
          .map<DropdownMenuItem<CocktailGroup>>((CocktailGroup value) {
        return DropdownMenuItem<CocktailGroup>(
          value: value,
          child: Text(
              value.toString().replaceAll('CocktailGroup.', '').toUpperCase()),
        );
      }).toList(),
    );
  }
}
