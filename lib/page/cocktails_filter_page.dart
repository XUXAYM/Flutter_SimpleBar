import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../provider/cocktails_notifier.dart';

class CocktailsFilterPage extends StatefulWidget {
  CocktailsFilterPage({Key key}) : super(key: key);

  @override
  _CocktailsFilterPageState createState() => _CocktailsFilterPageState();
}

class _CocktailsFilterPageState extends State<CocktailsFilterPage> {
  double _lowerValue = 0;
  double _upperValue = 100;
  var selectedRange = RangeValues(0.0, 100.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CocktailsPoolNotifier>(
        builder: (context, cocktailsData, _) => Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 32.0,
                ),
                FlutterSlider(
                  values: [_lowerValue, _upperValue],
                  max: 100,
                  min: 0,
                  rangeSlider: true,
                  step: FlutterSliderStep(step: 1.0),
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white24,
                      //border: Border.all(width: 3, color: Colors.blue),
                    ),
                    activeTrackBar: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                    ),
                  ),
                  // tooltip: FlutterSliderTooltip(
                  //   alwaysShowTooltip: true,
                  //   direction: FlutterSliderTooltipDirection.right,
                  //   boxStyle: FlutterSliderTooltipBox(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //   )
                  // ),
                  handlerAnimation: FlutterSliderHandlerAnimation(
                      curve: Curves.elasticOut,
                      reverseCurve: null,
                      duration: Duration(milliseconds: 400),
                      scale: 1.4),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    _lowerValue = lowerValue;
                    _upperValue = upperValue;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
