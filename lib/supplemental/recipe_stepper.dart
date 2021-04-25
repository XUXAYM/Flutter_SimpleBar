import 'package:flutter/material.dart';

class RecipeStepper extends StatelessWidget {
  RecipeStepper(this.recipe);

  final List<String> recipe;

  @override
  Widget build(BuildContext context) {
    return (recipe != null)
        ? Stepper(
            physics: NeverScrollableScrollPhysics(),
            currentStep: recipe.length - 1,
            controlsBuilder: (context, {onStepCancel, onStepContinue}) {
              return SizedBox(
                width: 1,
              );
            },
            steps: recipe.map<Step>((r) {
              return (recipe.last == r)
                  ? Step(
                      title: Text(r),
                      content: Text(''),
                      state: StepState.complete,
                    )
                  : Step(
                      title: Text(r),
                      content: Text(''),
                    );
            }).toList(),
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'No recipe',
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
