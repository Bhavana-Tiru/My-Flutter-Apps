import 'package:flutter/material.dart';

// import 'package:meals_app/screens/tabs.dart';
// import 'package:meals_app/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen> {
  var _glutenFreeSet = false;
  //widget.currentFilters; : widget property is not available here where you're initializing your class variables.
  //It is only available inside the methods.

  var _lactoseFreeSet = false;
  var _vegetarianFreeSet = false;
  var _veganFreeSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFreeSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFreeSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
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
      body: PopScope(
        //PopScope: Creates a widget that registers a callback to veto attempts by the user to dismiss the enclosing
        // requried Widget can also add fun(), canPop=true
        // PopScope(
        canPop: false,
        //When false, blocks the current route from being popped.
        onPopInvoked: (bool didPop) {
          //Called after a route pop was handled.
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeSet,
            Filter.lactoseFree: _lactoseFreeSet,
            Filter.vegetarian: _vegetarianFreeSet,
            Filter.vegan: _veganFreeSet,
          });
        },
        //   child: Column(...) // same code as shown in the next lecture
        // ),
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeSet = isChecked;
                });
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
              value: _lactoseFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeSet = isChecked;
                });
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
              value: _vegetarianFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFreeSet = isChecked;
                });
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
              value: _veganFreeSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFreeSet = isChecked;
                });
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
      ),
    );
  }
}
