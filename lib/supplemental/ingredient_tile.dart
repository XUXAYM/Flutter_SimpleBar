import 'package:flutter/material.dart';
import '../model/ingredient.dart';


class IngredientListTile extends StatefulWidget {
  IngredientListTile(this.ingredient, {this.subtitle: ''}) : assert(ingredient != null);

  final Ingredient ingredient;
  final String subtitle;
  @override
  _IngredientListTileState createState() => _IngredientListTileState();
}

class _IngredientListTileState extends State<IngredientListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ExcludeSemantics(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.network(
              widget.ingredient.imageSource,
            ),
          ),
          radius: 30,
        ),
      ),
      title: Text(widget.ingredient.title),
      subtitle: Text(widget.subtitle),
      trailing: IconButton(
        tooltip: 'Add to my bar',
        alignment: Alignment.center,
        icon: Icon(Icons.add, color: Theme.of(context).accentColor,),
        onPressed: ()
        {
        },
      ),
    );
  }
}
