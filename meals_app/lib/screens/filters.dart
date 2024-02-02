import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/providers/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

// get rid
//   @override
//   ConsumerState<FiltersScreen> createState() {
//     return _FiltersScreen();
//   }
// }

// class _FiltersScreen extends ConsumerState<FiltersScreen> {
//   var _glutenFreeSet = false;
//   //widget.currentFilters; : widget property is not available here where you're initializing your class variables.
//   //It is only available inside the methods.

//   var _lactoseFreeSet = false;
//   var _vegetarianFreeSet = false;
//   var _veganFreeSet = false;

  //get rid
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeSet = activeFilters[Filter.glutenFree]!;
  //   _lactoseFreeSet = activeFilters[Filter.lactoseFree]!;
  //   _vegetarianFreeSet = activeFilters[Filter.vegetarian]!;
  //   _veganFreeSet = activeFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    //watch():- executes the build method when ever the filtersProvider changes.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      //body: PopScope(
      //   //PopScope: Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing
      //   // requried Widget can also add fun(), canPop=true
      //   // PopScope(
      //   canPop: false,
      //   //When false, blocks the current route from being popped.
      //   onPopInvoked: () async {
      //(bool didPop)
      // onPopInvoked Called after a route pop was handled.

      //get rid
      //   WillPopScope(
      // onWillPop: () async {
      //   ref.read(filtersProvider.notifier).setFilters({
      //     Filter.glutenFree: _glutenFreeSet,
      //     Filter.lactoseFree: _lactoseFreeSet,
      //     Filter.vegetarian: _vegetarianFreeSet,
      //     Filter.vegan: _veganFreeSet
      //   });
      //   return true;
      // },

      //   child: Column(...) // same code as shown in the next lecture
      // ),
      body: Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              "Gluten-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            //to render some typically smaller text below the main title,the main label of the switch
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 32),
          ),
          //Creates a combination of a list tile and a switch.
          // The following arguments are required:
          // [value] determines whether this switch is on or off(bool).
          // [onChanged] is called when the user toggles the switch on or off(Function).
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              "Lactose-free",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include lactose-free meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            //to render some typically smaller text below the main title,the main label of the switch
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 32),
          ),

          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              "Vegetarian",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegetarian meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            //to render some typically smaller text below the main title,the main label of the switch
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 32),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              "Vegan",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include vegan meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            //to render some typically smaller text below the main title,the main label of the switch
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 32),
          ),
        ],
      ),
    );
  }
}
