import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import 'provider/pages_notifier.dart';
import 'colors.dart';
import 'page.dart';

class CategoryMenuPage extends StatelessWidget {
  final List<Widget> pages;

  CategoryMenuPage({
    Key key,
    @required this.pages,
  }){}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          color: kShrinePink100,
          child: ListView(
              children: Provider.of<PagesPoolNotifier>(context).pages
                  .map((Widget p) => _buildCategory(p, context))
                  .toList()),
        ),
      ),
    );
  }

  Widget _buildCategory(Widget page, BuildContext context) {
    final groupString = (page as PageWithTitle).title;
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Provider.of<PagesPoolNotifier>(context, listen: false).currentPage = page,
      child: page == Provider.of<PagesPoolNotifier>(context).currentPage
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
}
