import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewIteam extends StatefulWidget {
  const NewIteam({super.key});

  @override
  State<NewIteam> createState() {
    // TODO: implement createState
    return _NewIteamState();
  }
}

class _NewIteamState extends State<NewIteam> {
  final _formKey = GlobalKey<FormState>();
  // Creates a [LabeledGlobalKey], which is a [GlobalKey] with a label used for debugging.
  //The label is purely for debugging and not used for comparing the identity of the key.
  var _enteredName = '';
  var _enteredValue = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveitem() async {
    if (_formKey.currentState!.validate()) {
      //currentState=FormState, validate()- validators inside of Form
      setState(() {
        _isSending = true;
      });
      _formKey.currentState!.save();

      // to send request to Backend
      final url = Uri.https('flutter-prep-4d881-default-rtdb.firebaseio.com',
          'shopping-list.json');
      final response = await http.post(
        // post-store data in the backend
        //await is used on Future,
        // await added then flutter adds then method and it will give you access tothe response data onces it's there.
        url,
        headers: {
          //Map<String, String>
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredValue,
            'category': _selectedCategory.title,
          },
        ),
        //.then((response) =>
        // code)
      );
      final Map<String, dynamic> resData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(GroceryItem(
          id: resData['name'],
          name: _enteredName,
          quantity: _enteredValue,
          category: _selectedCategory));
      //response.statusCode == 201;
      //end

      // Navigator.of(context).pop(GroceryItem(
      //     id: DateTime.now().toString(),
      //     name: _enteredName,
      //     quantity: _enteredValue,
      //     category: _selectedCategory)); //to display groceries_list.dart.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new Iteam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                // instead of TextField()
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    //trim to remove excess whitespace at the begin and end
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },

                onSaved: (value) {
                  _enteredName = value!;
                },
                // allows to add a function which takes String as input(flutter) also returns a string (us).
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enteredValue.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          //trim to remove excess whitespace at the begin and end
                          return 'Must be a valid , positive number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredValue = int.parse(value!);
                        // parse will throw an error if it fails to convert the string to number.
                        //tryParse yields null here in our validator,
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveitem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator())
                        : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
