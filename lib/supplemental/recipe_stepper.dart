import 'package:flutter/material.dart';

class RecipeStepper extends StatefulWidget {
  RecipeStepper(this._recipe);
  List<String> _recipe;

  @override
  _RecipeStepperState createState() => _RecipeStepperState();
}

class _RecipeStepperState extends State<RecipeStepper> {

  @override
  Widget build(BuildContext context) {
    return  (widget._recipe != null) ? Stepper(
      physics: NeverScrollableScrollPhysics(),
      currentStep: widget._recipe.length - 1,
      controlsBuilder: (context, {onStepCancel, onStepContinue}) {
        return SizedBox(
          width: 1,
        );
      },
      steps: widget._recipe.map<Step>((r) {
        return(widget._recipe.last == r) ? Step(
          title: Text(r),
          content: Text(''),
          state: StepState.complete,
        ) : Step(
          title: Text(r),
          content: Text(''),
        ) ;
      }).toList(),
    ): Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text('No recipe', style: TextStyle( fontSize: 20),),
    );
  }
}
