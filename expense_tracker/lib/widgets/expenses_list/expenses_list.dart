import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final void Function(Expense expense) onRemoveExpense;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          //In dark mode magin will be null here
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseIteam(expenses[index]),
      ),
    );
    // ValueKey():-Creates a key that delegates its [operator==] to the given value.
    // ValueKey wants an input in the end it wants some input that can be used as unique identification criteria
    // or value for the widget to which the key is attached.
    //[Dismissible]s are commonly used in lists and removed from the list when dismissed.
    // ListView:-scrollable lists but it should only create those list items only
    //  when they are visible or about to become visible not if they're not visible.
    //iteamBuilder-it is a func and it should return a Widget. If iteamCount=2 then iteamBuilder is called twice.
    //inde values 0,1
  }
}
