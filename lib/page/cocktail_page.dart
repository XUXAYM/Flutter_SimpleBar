import 'package:flutter/material.dart';
import 'package:simplebar/model/cocktail.dart';
import 'package:simplebar/supplemental/recipe_stepper.dart';
import 'page.dart';

class CocktailPage extends StatefulWidget with PageWithTitle {
  CocktailPage(this._cocktail) :
        assert(_cocktail != null),
        title = _cocktail.title;

  final String title;
  final Cocktail _cocktail;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._cocktail.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: ListView(
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric( horizontal: 16.0, vertical: 10.0),
                 child: Image.network(widget._cocktail.imageSource, height: 300,),
               ),
               Text(widget._cocktail.description),
               Text('Degree: ' + ((widget._cocktail.degree != null) ? widget._cocktail.degree.toString() : 'No information')),
               Text('Group: ' + widget._cocktail.group.toString().replaceFirst('CocktailGroup.','')),
               Text('Basis: ' + ((widget._cocktail.basis != null) ? widget._cocktail.basis.title :'No information')),
               Text('Volume: ' + ((widget._cocktail.volume != null) ? widget._cocktail.volume.toString() : 'No information')),
               ExpansionPanelList(
                 children: [
                   ExpansionPanel(
                     canTapOnHeader: true,
                     headerBuilder: (context, isExpanded) {
                       return ListTile(
                         title: Text('Recipe'),
                       );
                     },
                     body: Column(
                       mainAxisSize: MainAxisSize.max,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Divider( indent: 30, endIndent: 30, height: 1, thickness: 1, color: Theme.of(context).primaryColor,),
                         RecipeStepper(widget._cocktail.recipe),
                       ],
                     ),
                     isExpanded: _isExpanded,
                   ),
                 ],
                 expansionCallback: (int index, bool isExpanded) {
                   setState(() {
                     _isExpanded = !_isExpanded;
                   });
                 },
               ),
             ],
          ))
        ],
      ),
    );
  }
}
