import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';

import 'constants.dart';

import 'provider/pages_notifier.dart';

import 'supplemental/flutter_search_bar.dart';
import 'supplemental/front_layer.dart';

class Backdrop extends StatefulWidget {
  final Widget currentPage;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;

  const Backdrop({
    @required this.currentPage,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
  })  : assert(currentPage != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null);

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
  Animation animation;
  SearchBar searchBar;
  GlobalKey backKey = GlobalKey();
  Size backPageSize;
  bool isFrontVisible = true;
  Widget backTitle = Text('MENU');

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      final keyContext = backKey.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox;
        setState(() {
          backPageSize = box.size;
        });
      }
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 0.0,
      vsync: this,
    );

    setAnimation(0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  AppBar buildAppBar(BuildContext context) {
    List<Widget> actions;
    switch (widget.frontLayer.runtimeType.toString()) {
      case 'CocktailsListPage':
        actions = [
          searchBar.getSearchAction(context),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () {
              if (Provider.of<PagesPoolNotifier>(context, listen: false)
                      .currentBackdropPage ==
                  Provider.of<PagesPoolNotifier>(context, listen: false)
                      .backPages[1]) {
                toggleButton();
              } else {
                backTitle = Text('FILTER');
                Provider.of<PagesPoolNotifier>(context, listen: false)
                        .currentBackdropPage =
                    Provider.of<PagesPoolNotifier>(context, listen: false)
                        .backPages[1];
              }
            },
          ),
        ];
        break;
      default:
        actions = [];
    }

    return AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      titleSpacing: 0.0,
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: kShrineBrown900,
          progress: CurvedAnimation(
              parent: _controller.view, curve: Interval(0.0, 0.5)),
        ),
        onPressed: _menuButtonToggle,
      ),
      title: _BackdropTitle(
        listenable: _controller.view,
        onPress: toggleButton, //_toggleBackdropLayerVisibility,
        frontTitle: widget.frontTitle,
        backTitle: backTitle,
      ),
      actions: actions,
    );
  }

  _menuButtonToggle() {
    if (Provider.of<PagesPoolNotifier>(context, listen: false)
            .currentBackdropPage ==
        Provider.of<PagesPoolNotifier>(context, listen: false).backPages[0]) {
      toggleButton();
    } else {
      backTitle = Text('MENU');
      if (isFrontVisible) {
        Provider.of<PagesPoolNotifier>(context, listen: false)
                .currentBackdropPage =
            Provider.of<PagesPoolNotifier>(context, listen: false).backPages[0];
      } else {
        toggleButton();
      }
    }
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

    if (old.backLayer == null) return;

    if (widget.backLayer != old.backLayer) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final keyContext = backKey.currentContext;
        if (keyContext != null) {
          final box = keyContext.findRenderObject() as RenderBox;
          var oldSize = backPageSize;
          setState(() {
            backPageSize = box.size;
          });
          if (!isFrontVisible) {
            setAnimation(backPageSize.height, startValue: oldSize.height);
            //_controller.animateBack(0.35, curve: Interval(0.0, 0.35));
            _controller.forward(from: 0.45);
          } else {
            toggleButton();
          }
        }
      });
    } else {
      if (!isFrontVisible) toggleButton();
    }
  }

  void toggleButton() {
    if (isFrontVisible) {
      setAnimation(backPageSize.height);
      isFrontVisible = false;
      _controller.forward();
    } else {
      setAnimation(backPageSize.height);
      isFrontVisible = true;
      _controller.reverse();
    }
  }

  void setAnimation(double endValue, {double startValue}) {
    setState(() {
      animation = Tween<double>(
              begin: startValue != null ? startValue : 0, end: endValue)
          .animate(CurvedAnimation(
              parent: _controller, curve: Curves.easeInOutQuart))
            ..addListener(() {
              setState(() {});
            });
    });
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: Container(
            color: Theme.of(context).primaryColor,
            height: double.infinity,
            width: double.infinity,
          ),
          excluding: isFrontVisible,
        ),
        ExcludeSemantics(
          child: FadeTransition(
            opacity: CurvedAnimation(
                parent: _controller.view, curve: Interval(0.4, 0.8)),
            child: Container(
              child: widget.backLayer,
              key: backKey,
            ),
          ),
          excluding: isFrontVisible,
        ),
        Transform.translate(
          offset: Offset(0.0, animation.value),
          child: FrontLayer(
            onTap: _menuButtonToggle,
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }
}

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
                parent: animation,
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset(0.5, 0.0),
                  end: Offset.zero,
                ).evaluate(animation),
                child: backTitle,
              ),
            ),
            Opacity(
              opacity: CurvedAnimation(
                parent: ReverseAnimation(animation),
                curve: Interval(0.5, 1.0),
              ).value,
              child: FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(-0.25, 0.0),
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