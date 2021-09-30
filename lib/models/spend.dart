import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uchiha_saving/models/category.dart';

enum SpendType { income, expense }

class Spend {
  final String title;
  final String description;
  final Timestamp createdAt;
  final double amount;
  final SpendType spendType;
  final Category category;
  final int priority; // high => 3, medium => 2, low => 1

  Spend(
      {required this.title,
      required this.description,
      required this.createdAt,
      required this.amount,
      required this.spendType,
      required this.category,
      required this.priority});

  Map<String, dynamic> get toMap => {
        "title": title,
        "description": description,
        "createdAt": createdAt,
        "amount": amount,
        "spendType": spendTypeToString(spendType),
        "category": category.toMap,
        "priority": priority,
      };

  static String spendTypeToString(SpendType spendType) =>
      spendType == SpendType.expense ? "expense" : "income";

  static SpendType stringToSpendType(String spendType) =>
      spendType == "expense" ? SpendType.expense : SpendType.income;

  factory Spend.fromDynamic(dynamic data) {
    return Spend(
      amount: data["amount"],
      category: Category.fromDynamic(data["category"]),
      createdAt: data["createdAt"],
      description: data["description"],
      priority: data["priority"],
      spendType: stringToSpendType(data["spendType"]),
      title: data["title"],
    );
  }
}
