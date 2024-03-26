import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/new_iteam.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({
    super.key,
  });

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'url here', 'shopping-list.json');
    final response = await http.get(url);

    // throw Exception('An error occurred!'); ->we we don't have internet connection.

    //print(
    //response.statusCode); // we will get status code in console. >400:-error

    //print(response.statusCode);

    // when we have wrong url
    if (response.statusCode >= 400) {
      setState(() {
        _error = "Failed to fetch data. Please try again later😔";
      });
    }

    // when we have no data
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final Map<String, dynamic> listData =
        json.decode(response.body); // no items response.body value will be null
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category),
      );
    }
    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      // to tell dart that newItem here is GroceryItem or null
      MaterialPageRoute(
        builder: (ctx) => const NewIteam(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _remoeveItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https('url here',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      //show error msg
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add new Grocery items!',
            style: GoogleFonts.lato(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
      if (_error != null) {
        content = Center(
          child: Text(_error!),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Groceries ',
          style: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _groceryItems.isEmpty
          ? content
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                onDismissed: (direction) => _remoeveItem(_groceryItems[index]),
                child: ListTile(
                  title: Text(
                    _groceryItems[index].name,
                  ),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  trailing: Text(
                    _groceryItems[index].quantity.toString(),
                  ),
                ),
              ),
            ),

      // Padding(
      //   padding: const EdgeInsets.all(20),
      // decoration: ,
      //   child: Column(
      //     children: [
      //       Row(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           Container(
      //             width: 30,
      //             height: 30,
      //             decoration: BoxDecoration(
      //               color: Colors.blue,
      //               borderRadius: BorderRadius.circular(75),
      //             ),
      //           ),
      //           const SizedBox(
      //             width: 30,
      //           ),
      // const Text(groceryItems.title),
      //           const SizedBox(
      //             width: 270,
      //           ),
      //           const Text('1'),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
