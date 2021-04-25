import 'package:flutter/material.dart';

class CocktailsFilterPage extends StatefulWidget {
  CocktailsFilterPage({Key key}) : super(key: key);

  @override
  _CocktailsFilterPageState createState() => _CocktailsFilterPageState();
}

class _CocktailsFilterPageState extends State<CocktailsFilterPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              min: 0,
              max: 100,
              value: 0,
              onChanged: (value) {

              },
              onChangeEnd: (value) {

              },
              onChangeStart: (value) {

              },
            ),
            Wrap(
              children: [
                FilterChip(label: Text('mocktails'), onSelected: (value) {

                },)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
