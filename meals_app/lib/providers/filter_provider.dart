import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:meals_app/providers/meals_provider.dart";

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; //not allowed!=> mutatiing state
    state = {
      ...state,
      filter: isActive, //copies existing map key value pairs
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
        (ref) => FilterNotifier()); // used in filters.dart

final filtersMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false; //! meal.isGlutenFree- not true(!)
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false; //! meal.isGlutenFree- not true(!)
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false; //! meal.isGlutenFree- not true(!)
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false; //! meal.isGlutenFree- not true(!)
    }
    return true;
  }).toList();
});
