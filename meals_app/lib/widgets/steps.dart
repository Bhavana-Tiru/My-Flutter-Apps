import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_provider.dart';

class Steps extends ConsumerWidget {
  const Steps({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriateMealsProvider);
    final isFavoriate = favoriteMeals.contains(meal);
    //ref is used to listen to the providers.
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriateMealsProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
              //notifier gives acess to favorites_provider.dart.
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? 'Meal added' : 'Meal removed'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              //It will create the animation and start the animation.
              // And it will start the animation whenever the child changes.
              // So it will automatically detect this and play the animation as the child updates.
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                //child here is Icon
                //animation is lowerBound:0, upperBound: 1,
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  //or Tween<double>(enum)(begin: 0.5, end: 1)
                  child: child,
                );
              },
              child: Icon(
                isFavoriate ? Icons.favorite_sharp : Icons.favorite_border,
                key: ValueKey(isFavoriate),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Ingredients :",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final ingrediants in meal.ingredients)
                Text(
                  ingrediants,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Steps :",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 14,
              ),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
