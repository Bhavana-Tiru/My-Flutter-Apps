import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInnitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreen();
}

class _TabsScreen extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriateMeals = [];
  Map<Filter, bool> _selectedFilters = kInnitialFilters;

  void _showInfoMsg(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toogleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriateMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriateMeals.remove(meal);
      });
      _showInfoMsg(('Meal is no longer favoriate...'));
    } else {
      setState(() {
        _favoriateMeals.add(meal);
      });
      _showInfoMsg("Marked as a favorite 😊!");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInnitialFilters;

        // the double question mark operator,

        // which is an operator built into Dart

        // which simply checks whether the value in front

        // of it is null, and if it is null, the fallback value defined

        // after the double question marks will be used.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final avaiableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false; //! meal.isGlutenFree- not true(!)
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false; //! meal.isGlutenFree- not true(!)
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false; //! meal.isGlutenFree- not true(!)
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false; //! meal.isGlutenFree- not true(!)
      }
      return true;
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toogleMealFavoriteStatus,
      availableMeales: avaiableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealScreen(
        meals: _favoriateMeals,
        onToggleFavorite: _toogleMealFavoriteStatus,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
