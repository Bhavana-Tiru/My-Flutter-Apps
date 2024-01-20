import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => ExpenseIteam(expenses[index]),
    );
    // ListView:-scrollable lists but it should only create those list items only
    //  when they are visible or about to become visible not if they're not visible.
    //iteamBuilder-it is a func and it should return a Widget. If iteamCount=2 then iteamBuilder is called twice.
    //inde values 0,1
  }
}
