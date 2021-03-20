import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/page/page.dart';
import 'package:simplebar/provider/pages_notifier.dart';

import 'page/cocktails_filter_page.dart';
import 'supplemental/flutter_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'colors.dart';
import 'page/home.dart';
import 'supplemental/cocktails_dropdown_button.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Widget currentPage;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentPage,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentPage != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  _BackdropState() {
    searchBar = new SearchBar(
        closeOnSubmit: true,
        inBar: true,
        setState: setState,
        buildDefaultAppBar: buildAppBar,
        onSubmitted: (value) {},
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.close_menu,
          color: kShrineBrown900,
          progress: _controller.view,
        ),
        onPressed: () {
          _toggleBackdropLayerVisibility();
        },
      ),
      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: _toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: widget.backTitle,
      ),
      actions: <Widget>[
        searchBar.getSearchAction(context),
        IconButton(
          icon: Icon(Icons.tune),
          onPressed: () {
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentPage != old.currentPage) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    //const double layerTitleWidth = 48.0;
    //final Size layerSize = constraints.biggest;

    final panelSize = constraints.biggest;
    final closedPercentage = _frontLayerVisible
        ? (panelSize.height - layerTitleHeight) / panelSize.height
        : 1.0;
    // final closedPercentage = _frontLayerVisible
    //     ? (panelSize.width - layerTitleWidth) / panelSize.width
    //     : 1.0;
    final openPercentage = 0.0 / panelSize.height;
    final panelDetailsPosition = Tween<Offset>(
      begin: Offset(0.0, closedPercentage),
      end: Offset(0.0, openPercentage),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        SlideTransition(
          position: panelDetailsPosition,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//////////////////////////////////////////////////////////////////////////////// The end of Backdrop Class
class _BackdropTitle extends AnimatedWidget {
  final Function onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    Key key,
    Listenable listenable,
    this.onPress,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(frontTitle != null),
        assert(backTitle != null),
        super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.listenable;

    return DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.headline6,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: Row(children: <Widget>[
        Stack(
          children: <Widget>[
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(0.5, 0.0),
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(-0.25, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: frontTitle,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  const _FrontLayer({
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
                        BorderRadius.vertical(top: Radius.circular(15)),
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
                              ? Text(
                                  (child as PageWithTitle).title.toUpperCase())
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
