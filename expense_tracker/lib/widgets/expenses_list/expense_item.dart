import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class ExpenseIteam extends StatelessWidget {
  const ExpenseIteam(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(children: [
          Text(expense.title),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              // toStringAsFixed(fractionDigits=(2))
              // toStringAsFixed simply ensures the value 12.3433=>12.34 that will be limited to two digits after the dot.
              //if user enters values with to many decimal places it takes only 2 values after the dot.
              const Spacer(),
              //Spacer is a Widget that is build in Column or Row to tell flutter that it should create a widget,
              //that takes the all space that can get b/w another widgets.
              Row(
                children: [
                  Icon(categoryIcons[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense
                      .formattedDate), // we should not define () here because it is getter not a func.
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
