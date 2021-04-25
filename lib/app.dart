import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/provider/settings_notifier.dart';

import 'page/favorite_cocktails_page.dart';
import 'provider/pages_notifier.dart';
import 'backdrop.dart';
import 'constants.dart';

class SimpleBarApp extends StatefulWidget {
  @override
  _SimpleBarAppState createState() => _SimpleBarAppState();
}

class _SimpleBarAppState extends State<SimpleBarApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleBar',
      home: Backdrop(
        currentPage: Provider.of<PagesPoolNotifier>(context).currentFrontPage,
        frontLayer: Provider.of<PagesPoolNotifier>(context).currentFrontPage,
        backLayer: Provider.of<PagesPoolNotifier>(context).currentBackdropPage,
        frontTitle: Text('SIMPLE BAR'),
      ),
      theme: kTheme,
      darkTheme: kDarkTheme,
      themeMode: Provider.of<SettingsNotifier>(context).mode,
      routes: {
        '/favorite': (context) => FavoriteCocktailsPage(),
      },
    );
  }
}



