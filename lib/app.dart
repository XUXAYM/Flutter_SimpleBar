import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/provider/cocktails_notifier.dart';

import 'backdrop.dart';
import 'colors.dart';
import 'home.dart';
import 'model/cocktail.dart';
import 'category_menu_page.dart';

class SimpleBarApp extends StatefulWidget {
  @override
  _SimpleBarAppState createState() => _SimpleBarAppState();
}

class _SimpleBarAppState extends State<SimpleBarApp> {
  CocktailGroup _currentGroup = CocktailGroup.all;

  void _onGroupTap(CocktailGroup group) {
    setState(() {
      _currentGroup = group;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CocktailsNotifier(),
      child: MaterialApp(
        title: 'SimpleBar',
        home: Backdrop(
          currentGroup: CocktailGroup.all,
          frontLayer: CocktailsListPage(),
          backLayer: CategoryMenuPage(
            currentGroup: _currentGroup,
            onGroupTap: _onGroupTap,
        ),
          frontTitle: Text('SHRINE'),
          backTitle: Text('MENU'),
        ),
        theme: _kShrineTheme,
      ),
    );
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      colorScheme: base.colorScheme.copyWith(
        secondary: kShrineBrown900,
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}
