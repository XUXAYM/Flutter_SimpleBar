import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/tool.dart';
import '../provider/tools_notifier.dart';

import '../provider/ingredients_notifier.dart';
import '../model/cocktail.dart';
import '../supplemental/ingredient_tile.dart';
import '../supplemental/recipe_stepper.dart';
import 'page.dart';

class CocktailPage extends StatefulWidget with PageWithTitle {
  CocktailPage(this._cocktail) : title = _cocktail.title;

  final String title;
  final Cocktail _cocktail;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  bool _isRecipeExpanded = false;
  bool _isIngredientsExpanded = false;
  bool _isToolsExpanded = false;

  @override
  Widget build(BuildContext context) {
    var ingredientsProvider = context.watch<IngredientsPoolNotifier>();
    var toolsProvider = context.watch<ToolsPoolNotifier>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget._cocktail.title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 10.0),
                  child: Image.network(
                    widget._cocktail.imageSource,
                    height: 300,
                  ),
                ),
                Text(widget._cocktail.description),
                Text('Degree: ' +
                    ((widget._cocktail.degree != null)
                        ? widget._cocktail.degree.toString()
                        : 'No information')),
                Text('Group: ' +
                    widget._cocktail.group
                        .toString()
                        .replaceFirst('CocktailGroup.', '')),
                Text('Basis: ' +
                    ((widget._cocktail.basis != null)
                        ? widget._cocktail.basis.toString()
                        : 'No information')),
                Text('Volume: ' +
                    ((widget._cocktail.volume != null)
                        ? widget._cocktail.volume.toString()
                        : 'No information')),
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
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          RecipeStepper(widget._cocktail.recipe),
                        ],
                      ),
                      isExpanded: _isRecipeExpanded,
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text('Ingredients'),
                        );
                      },
                      body: Column(
                        children: [
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          widget._cocktail.ingredients.keys.length > 0
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 15.0, 0.0, 15.0),
                                  child: Column(children: [
                                    for (int id
                                        in widget._cocktail.ingredients.keys)
                                      IngredientListTile(
                                        ingredientsProvider.getById(id),
                                        subtitle: widget
                                                ._cocktail.ingredients[id]
                                                .toString() +
                                            ' ' +
                                            ingredientsProvider
                                                .getById(id)
                                                .measure
                                                .toString()
                                                .replaceAll(
                                                    'IngredientMeasure.', ''),
                                      )
                                  ]),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'No ingredients',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                        ],
                      ),
                      isExpanded: _isIngredientsExpanded,
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text('Tools'),
                        );
                      },
                      body: Column(
                        children: [
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            height: 1,
                            thickness: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          widget._cocktail.tools.keys.length > 0
                              ? Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0.0, 15.0, 0.0, 15.0),
                                  child: Column(children: [
                                    for (int id in widget._cocktail.tools.keys)
                                      ToolListTile(
                                          toolsProvider.getById(id),
                                          quantity: widget._cocktail.tools[id],)
                                  ]),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'No tools',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                        ],
                      ),
                      isExpanded: _isToolsExpanded,
                    ),
                  ],
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      switch (index) {
                        case 0:
                          _isRecipeExpanded = !_isRecipeExpanded;
                          break;
                        case 1:
                          _isIngredientsExpanded = !_isIngredientsExpanded;
                          break;
                        case 2:
                          _isToolsExpanded = !_isToolsExpanded;
                          break;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ToolListTile extends StatelessWidget {
  ToolListTile(this.tool, {this.quantity: 1}) : assert(tool != null), assert(quantity != null && quantity > 0);

  final int quantity;
  final Tool tool;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExcludeSemantics(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.network(
              tool.imageSource,
            ),
          ),
          radius: 30,
        ),
      ),
      title: Text(tool.title),
      subtitle: Text(quantity.toString()+' pcs'),
    );
  }
}
