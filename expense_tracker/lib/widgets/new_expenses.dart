import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    // TODO: implement createState
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _seletedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
    //).then((value) => );
    //Synatx: Future<DateTime?> showDatePicker.
    // Future is a data type that is object that wraps a value which u don't have yet but which u will have in future.

    //Option 1: then will be executed when the value is picked by the user
    //Option 2: adding async and await for future pick.

    //the await keyword internally simply tells Flutter this value that should be stored
    //in pick date won't be available immediatel but at least at some point in the future
    //and Flutter should therefore basically wait for that value before it stores it in that variable.
  }

  void _submitExpenseDate() {}

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    // Only State classes can implement this "dispose" method(StatelessWidget can't).That's why we should only use StatefulWid here.
    super.dispose();
  }
  //which you create here would live on
  //in memory even though the widget is not visible anymore.
  // That's why when using TextEditingController
  // you should also always add the special dispose method
  // to your state class here.

  //When you create a TextEditingController here
  //you also have to tell Flutter to delete that controller\
  //when the widget is not needed anymore.

  //TextEditingController: to optimse user input,
  //creates a object that can be passed a value to
  // text field to flutter to store input values given by user.

  //1. way to get input given by user to Debug console
  // var _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            //onChanged: called when user insert or delete some text.
            //it returns a void func(String).
            // Stirng value here will be the value entered by the user in the text field.
            //it is called when the value is changed by user.
            maxLength: 50,
            //max length of input user should enter.
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    prefixText: '\$ ', // this $ sign will be in front of amount
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? "No date selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton(
                value: _seletedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _seletedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // removes the overlay from the screen
                },
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseDate;
                },
                child: const Text("save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
