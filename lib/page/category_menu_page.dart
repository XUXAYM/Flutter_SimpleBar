import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../provider/pages_notifier.dart';
import 'page.dart';

class CategoryMenuPage extends StatelessWidget {
  CategoryMenuPage({ Key key,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          color: Theme.of(context).appBarTheme.color,
          child: ListView(
              children: Provider.of<PagesPoolNotifier>(context, listen: false).frontPages
                  .map((Widget p) => _buildCategory(p, context))
                  .toList()),
        ),
      ),
    );
  }

  Widget _buildCategory(Widget page, BuildContext context) {
    final groupString = (page as PageWithTitle).title.toUpperCase();
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Provider.of<PagesPoolNotifier>(context, listen: false).currentFrontPage = page,
      child: page == Provider.of<PagesPoolNotifier>(context).currentFrontPage
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
          style: theme.textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
