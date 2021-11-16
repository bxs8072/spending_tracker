import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

List<Transaction> list1 = [
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 01)),
      amount: 200.00,
      transactionType: TransactionType.expense,
      category: Category.transportation,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 09)),
      amount: 255.00,
      transactionType: TransactionType.expense,
      category: Category.home,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 09)),
      amount: 255.00,
      transactionType: TransactionType.expense,
      category: Category.home,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 14)),
      amount: 975.00,
      transactionType: TransactionType.expense,
      category: Category.coffee,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 19)),
      amount: 775.00,
      transactionType: TransactionType.expense,
      category: Category.grocery,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 29)),
      amount: 1000.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 29)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 1),
];

List<Map<String, dynamic>> getList() {
  List<Map<String, dynamic>> _list = [];

  int day = list1[0].createdAt.toDate().day;
  double amount = list1[0].amount;

  _list.add({
    "day": day,
    "amount": amount,
  });

  for (int i = 1; i < list1.length; i++) {
    if (list1[i].createdAt.toDate().day == day) {
      _list.add({
        "day": list1[i].createdAt.toDate().day,
        "amount": list1[i].amount + amount,
      });
    } else {
      _list.add({
        "day": list1[i].createdAt.toDate().day,
        "amount": list1[i].amount,
      });
    }

    if (i < list1.length - 1) {
      day = list1[i + 1].createdAt.toDate().day;
      amount = list1[i + 1].amount + amount;
    }
  }

  return _list;
}
