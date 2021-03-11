import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'model/cocktail.dart';

import 'colors.dart';
import 'model/product.dart';

class CategoryMenuPage extends StatelessWidget {
  final CocktailGroup currentGroup;
  final ValueChanged<CocktailGroup> onGroupTap;
  final List<CocktailGroup> _groups = CocktailGroup.values;

  const CategoryMenuPage({
    Key key,
    @required this.currentGroup,
    @required this.onGroupTap,
  })  : assert(currentGroup != null),
        assert(onGroupTap != null);

  Widget _buildCategory(CocktailGroup group, BuildContext context) {
    final groupString =
    group.toString().replaceAll('CocktailGroup.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onGroupTap(group),
      child: group == currentGroup
          ? Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            groupString,
            style: theme.textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.0),
          Container(
            width: 70.0,
            height: 2.0,
            color: kShrinePink400,
          ),
        ],
      )
          : Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          groupString,
          style: theme.textTheme.bodyText1.copyWith(
              color: kShrineBrown900.withAlpha(153)
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        color: kShrinePink100,
        child: ListView(
            children: _groups
                .map((CocktailGroup g) => _buildCategory(g, context))
                .toList()),
      ),
    );
  }
}
