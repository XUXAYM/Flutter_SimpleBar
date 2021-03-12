import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:simplebar/provider/cocktails_notifier.dart';

import 'model/cocktail.dart';
import 'colors.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final CocktailGroup currentGroup;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentGroup,
    @required this.frontLayer,
    @required this.backLayer,
    @required this.frontTitle,
    @required this.backTitle,
  })  : assert(currentGroup != null),
        assert(frontLayer != null),
        assert(backLayer != null),
        assert(frontTitle != null),
        assert(backTitle != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
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
        // TODO: Add shortcut to login screen from trailing icons (104)
        IconButton(
          icon: Icon(
            Icons.search,
            semanticLabel: 'login', // New code
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.login,
            semanticLabel: 'login', // New code
          ),
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => SignInDemo()),
            );*/
          },
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentGroup != old.currentGroup) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    //final double layerTop = layerSize.height - layerTitleHeight;
    final double layerRight = layerSize.width - layerTitleHeight;

    // Animation<RelativeRect> layerAnimation = RelativeRectTween(
    //   begin: RelativeRect.fromLTRB(
    //       0.0, layerTop, 0.0, layerTop - layerSize.height),
    //   end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    // ).animate(_controller.view);

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          layerRight, 0.0, layerRight - layerSize.width, 0.0),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        ExcludeSemantics(
          child: widget.backLayer,
          excluding: _frontLayerVisible,
        ),
        PositionedTransition(
          rect: layerAnimation,
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
        // branded icon
/*        SizedBox(
          width: 72.0,
          child: IconButton(
            padding: EdgeInsets.only(right: 8.0),
            onPressed: this.onPress,
            icon: Stack(children: <Widget>[
              Opacity(
                opacity: animation.value,
                child: ImageIcon(AssetImage('assets/slanted_menu.png')),
              ),
              FractionalTranslation(
                translation: Tween<Offset>(
                  begin: Offset.zero,
                  end: Offset(1.0, 0.0),
                ).evaluate(animation),
                child: Icon(Icons.coronavirus_rounded),
              )
            ]
            ),
          ),
        ),*/
        // Here, we do a custom cross fade between backTitle and frontTitle.
        // This makes a smooth animation between the two texts.
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
  // TODO: Add on-tap callback (104)
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
      elevation: 5.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onTap,
                child: Material(
                  shape: BeveledRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(27.0)),
                  ),
                  elevation: 5,
                  child: Container(
                    height: 47.0,
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                child: CocktailGroupDropdownButton(),
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

class CocktailGroupDropdownButton extends StatefulWidget {
  @override
  _CocktailGroupDropdownButton createState() => _CocktailGroupDropdownButton();
}

class _CocktailGroupDropdownButton extends State<CocktailGroupDropdownButton> {
  @override
  Widget build(BuildContext context) {
    final _notifier = Provider.of<CocktailsNotifier>(context);
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
