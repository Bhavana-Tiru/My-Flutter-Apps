import 'package:flutter/material.dart';

import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/models/categoey.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeales});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeales;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeales
        .where((meal) => meal.categories.contains(category.id))
        .toList(); // whole return true or false

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealScreen(
          meals: filteredMeals,
          title: category.title,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView(
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
    );
  }
}