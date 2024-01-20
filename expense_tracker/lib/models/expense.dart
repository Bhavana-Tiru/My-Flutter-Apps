import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
//yMd():-creates a formatted object which we can then use to formatted date
//It is a utility object. DateFormat class, yMd is a constructor func[y-year, M-month, d-day]

const uuid = Uuid();

enum Category { food, travel, leisure, work }
// dart treats this values kind of Strings but these are not String it is not decalred in ''.
// enum allows us to create a custom type which simply is a combination of predefined allowed values.You define those allowed values
//between opening and closing curly braces.
//Syntax: enum Category{}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id; //we use- uuid for generating  random id numbers
  final String title;
  final double amount;
  final DateTime date; //DateTime datatype- allows to represent time values.
  final Category category;

  String get formattedDate {
    return formatter.format(date);
    //formatting dates manually is difficult so we use intl(3rd party package in dart)
  }
  //Getters are basically "computed properties"=>Properties that are dynamically derived, based on other class properties.
}
