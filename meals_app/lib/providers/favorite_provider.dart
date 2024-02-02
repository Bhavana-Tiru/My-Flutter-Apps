import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  //StateNotifier is actually a generic class, just as the built-in state class,
  // here I'll therefor at angled brackets to in the end tell flutter_riverpod which kind of data will be managed by this notifier,
  // A-the initial value, in this case initially an empty list of meals.
  // B-all the methods that should exist to change that value, to change that list in this case.

  FavoriteMealNotifier() : super([]);
  // we add such a initializer list by adding a colon after the constructor function parameter list,
  // and then here we call super to reach out to the parent class .
  // The value can be anything but it should be of that type that you define here between the angled brackets.

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealFavorite = state.contains(meal);

    if (mealFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; //where gives a new list
    } else {
      state = [...state, meal];
      return true;
    }
  }

// there is this globally available state property.
// This property is made available by the StateNotifier class.
// Now this state property holds your data,
// so in this case a list of meals.
// And, again, calling add or remove on that
// would not be allowed.
// Instead, you have to reassign it
// by using the assignment operator to a new list
// So a new list, no matter if you are adding a meal
// or removing a meal.
}

final favoriateMealsProvider =
    StateNotifierProvider<FavoriteMealNotifier, List<Meal>>(
        (ref) => FavoriteMealNotifier());

//StateNotifierProvider<FavoriteMealNotifier, List<Meal>>((ref) => FavoriteMealNotifier()); :-
//   StateNotifierProvider is a generic type
// and it does understand
// that it returns a FavoriteMealsNotifier,
// but it does not understand, unfortunately,
// which data this FavoriteMealsNotifier will yield in the end.
// Therefore, here we should add angled brackets
// and add two generic type definitions here.
// The first one is FavoriteMealsNotifier,
// but the second one then is the data that will be yielded
// by the FavoriteMealsNotifier in the end.
// And here that will be a list of meals.


//(ref) => FavoriteMealNotifier() :- 
//the value which I do provide here
// is now an instance of this notifier.
// So we use this class name FavoriteMealsNotifier,
// and instantiate this.
// And now this provider returns an instance
// of our notifier class
// so that we have this class for editing the state
// and for retrieving the state.
