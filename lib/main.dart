import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'provider/cocktails_notifier.dart';
import 'provider/pages_notifier.dart';

void main() => runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => CocktailsPoolNotifier()),
        ChangeNotifierProvider(create: (_) => PagesPoolNotifier()),
      ], child: SimpleBarApp()),
    );
