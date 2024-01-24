import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

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

  void _submitExpenseDate() {
    final enteredAmount = double.tryParse(_amountController.text);

    //tryParse :- double? tryParse(String source)
    //var value = double.tryParse('3.14'); // 3.14
    // value = double.tryParse('  3.14 \xA0'); // 3.14
    // value = double.tryParse('0.'); // 0.0
    // value = double.tryParse('.0'); // 0.0
    // value = double.tryParse('-1.e3'); // -1000.0
    // value = double.tryParse('1234E+7'); // 12340000000.0
    // value = double.tryParse('+.12e-9'); // 1.2e-10
    // value = double.tryParse('-NaN'); // NaN
    // value = double.tryParse('0xFF'); // null
    // value = double.tryParse(double.infinity.toString()); // Infinity

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //trim():- If the string contains leading or trailing whitespace,
      // a new string with no leading and no trailing whitespace is returned
      showDialog(
        //showDialog:- which will show some info or error dialogue on the screen. pop-up on the screen.
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text(
              "Please make sure a  valid title, amount, date and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _seletedCategory),
    );
    Navigator.pop(context);
  }

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
    // we can get theamount of space taken by keyboard
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      // print(constraints.minWidth);
      // print(constraints.maxWidth);
      // print(constraints.minHeight);
      // print(constraints.maxHeight);
      //diaplays the min and max width, height of the screen .

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text("Title"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          maxLength: 20,
                          decoration: const InputDecoration(
                            prefixText:
                                '\$ ', // this $ sign will be in front of amount
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                    ],
                  )
                else
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
                if (width >= 600)
                  Row(
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
                      const SizedBox(width: 24),
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
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _amountController,
                          maxLength: 20,
                          decoration: const InputDecoration(
                            prefixText:
                                '\$ ', // this $ sign will be in front of amount
                            label: Text("Amount"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      if (width >= 600)
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // removes the overlay from the screen
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _submitExpenseDate();
                              },
                              child: const Text("save Expense"),
                            ),
                          ],
                        )
                      else
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
                        ),
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
                        Navigator.pop(
                            context); // removes the overlay from the screen
                      },
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseDate();
                      },
                      child: const Text("save Expense"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
    //viewInserts to adjust UI.
  }
}
