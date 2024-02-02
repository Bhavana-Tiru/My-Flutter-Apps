import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/models/categoey.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeales});

  final List<Meal> availableMeales;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// here Explicit Animation is used
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //with:- A keyword which allows you to add a so-called Mixin to a class
  // which you can think of a another class being merged into this class behind the scenes
  // and offering certain features to this class therefore.

  //SingleTickerProviderStateMixin:- provides various features that are needed by the flutter animation system.
  // If multiple animation controller are present we should use TickerProviderStateMixin.
  late AnimationController _animationController;
  //AnimationController:- A controller for an animation.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
      //default values and the values should be set to the animation
    );
    //vsync: sync parameter is responsible for making sure that this animation
    //executes for every frame. So, typically 60 times per second.
    _animationController.forward();
    //starts the animation till the end until we use stop method.
    // we can also use repeat() to repeat it and it always restart it once it's done.
  }

  @override
  void dispose() {
    //clean up work
    _animationController
        .dispose(); //AnimationController will be removed once this widget here is removed to make sure we don't cause memory loss.
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeales
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // whole return true or false

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: filteredMeals,
          title: category.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: [
            // alternative way of map = availableCategories.map((category)=>CategoryGridIteam(category: category).toList())
            for (final category in availableCategories)
              CategoryGridIteam(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ),
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(
                begin: const Offset(0,
                    0.3), //Offset(double dx, double dy):- dx:0% in x-axis, dy: 30% in y-axis
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
                //animate:-  animate takes an argument which we can use to get more control over how the animation is played back.
                //CurvedAnimation:CurvedAnimation in the end is a configuration object
                //for creating such an animation with help of this animate method here.
              ),
              child: child,
            )
        //offset:- An offset then is a special kind of value used by Flutter to describe the well,
        //amount of offset of an element from the actual position it would normally take.

        //drive is a built in method used to build a animation based on some other value.
        // drive simply allows us to translate our animation between zero and one
        // to an animation between two other values.

        //drive wants an animatable child and such an animatable child can be built
        // with Flutter's Tween class. The Tween class creates tween objects and the name tween simply comes from the fact
        // that this class and these objects are all about animating or describing the transition between, hence the name tween, two values.

        // another way for builder animation:-
        // Padding(
        //       padding:
        //           EdgeInsets.only(top: 100 - _animationController.value * 100),
        //       child: child,
        //     )
        //value:-value in _animatedController which is lowerBound: 0(0*100=0), upperBound: 1 (1*100=100),
        //only the Padding widget is re-executed not the GridView
        );
  }
}

//We can listen and update the parts of UI by using AnimatedBuilder given by flutter
//this would allow you to improve the performance of an animation by making sure that not all the items
//that are part of the animated item are rebuilt and reevaluated as long as the animation is running.
