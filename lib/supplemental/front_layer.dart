import 'package:flutter/material.dart';
import 'package:simplebar/page/home.dart';
import 'package:simplebar/page/page.dart';

import 'cocktails_dropdown_button.dart';

class FrontLayer extends StatelessWidget {
  const FrontLayer({
    Key key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  elevation: 5,
                  child: DefaultTextStyle(
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline6
                        .copyWith(fontSize: 16),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: child is PageWithTitle
                              ? Text((child as PageWithTitle)
                              .title
                              .toUpperCase())
                              : null,
                        ),
                        Container(
                          height: 47.0,
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                child: (this.child is CocktailsListPage)
                    ? CocktailGroupDropdownButton()
                    : null,
              ),
            ],
            alignment: AlignmentDirectional.centerEnd,
          ),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}
