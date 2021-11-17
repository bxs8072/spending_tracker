import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:uchiha_saving/models/category.dart';
import 'package:uchiha_saving/models/transaction.dart';

List<Transaction> list1 = [
  Transaction(
      title: 'Food',
      description: 'Meat',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 01)),
      amount: 200.00,
      transactionType: TransactionType.expense,
      category: Category.grocery,
      priority: 3),
  Transaction(
      title: 'Food',
      description: 'Port of Peri Peri',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 02)),
      amount: 100.00,
      transactionType: TransactionType.expense,
      category: Category.restaurant,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Coffee',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 03)),
      amount: 6.00,
      transactionType: TransactionType.expense,
      category: Category.coffee,
      priority: 1),
  Transaction(
      title: 'Rent',
      description: 'Home Rent',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 03)),
      amount: 1450.00,
      transactionType: TransactionType.expense,
      category: Category.rent,
      priority: 3),
  Transaction(
      title: 'Food',
      description: 'Breakfast',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 04)),
      amount: 25.00,
      transactionType: TransactionType.expense,
      category: Category.restaurant,
      priority: 1),
  Transaction(
      title: 'Gas',
      description: 'Gasoline',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 05)),
      amount: 200.00,
      transactionType: TransactionType.expense,
      category: Category.gas,
      priority: 2),
  Transaction(
      title: 'School',
      description: 'Fees',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 06)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 3),
  Transaction(
      title: 'Water',
      description: 'Water & Sewage utilities',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 07)),
      amount: 50.00,
      transactionType: TransactionType.expense,
      category: Category.water,
      priority: 2),
  Transaction(
      title: 'Entertainment',
      description: 'Park',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 08)),
      amount: 200.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 3),
  Transaction(
      title: 'Income',
      description: 'Salary',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 15)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.income,
      priority: 3),
  Transaction(
      title: 'Stationary',
      description: 'School Items',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 09)),
      amount: 500.00,
      transactionType: TransactionType.expense,
      category: Category.stationery,
      priority: 2),
  Transaction(
      title: 'Electricity',
      description: 'Electricity',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 10)),
      amount: 350.00,
      transactionType: TransactionType.expense,
      category: Category.electricity,
      priority: 3),
  Transaction(
      title: 'Transportation',
      description: 'Metro & Bus',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 11)),
      amount: 1000.00,
      transactionType: TransactionType.expense,
      category: Category.transportation,
      priority: 2),
  Transaction(
      title: 'Work',
      description: 'Work',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 12)),
      amount: 30.00,
      transactionType: TransactionType.expense,
      category: Category.work,
      priority: 2),
  Transaction(
      title: 'School',
      description: 'Fees',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 13)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.school,
      priority: 3),
  Transaction(
      title: 'Miscelleneous',
      description: 'Insurance',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 14)),
      amount: 2220.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 3),
  Transaction(
      title: 'Laptop',
      description: 'Electronics',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 17)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 1),
  Transaction(
      title: 'Food',
      description: 'Grocery',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 19)),
      amount: 350.00,
      transactionType: TransactionType.expense,
      category: Category.grocery,
      priority: 3),
  Transaction(
      title: 'Amazon',
      description: 'Online Shopping',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 21)),
      amount: 900.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 1),
  Transaction(
      title: 'Gas',
      description: 'Gasoline',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 26)),
      amount: 200.00,
      transactionType: TransactionType.expense,
      category: Category.gas,
      priority: 2),
  Transaction(
      title: 'School',
      description: 'Fees',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 28)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.school,
      priority: 3),
  Transaction(
      title: 'Clothes',
      description: 'Shopping',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 24)),
      amount: 2000.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 3),
  Transaction(
      title: 'Wifi',
      description: 'Internet',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 10, 30)),
      amount: 60.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 3),
  Transaction(
      title: 'Rent',
      description: 'Rent',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 01)),
      amount: 1517.00,
      transactionType: TransactionType.expense,
      category: Category.rent,
      priority: 3),
  Transaction(
      title: 'School',
      description: 'Fees',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 02)),
      amount: 1000.00,
      transactionType: TransactionType.expense,
      category: Category.school,
      priority: 3),
  Transaction(
      title: 'Electricity',
      description: 'Electricity',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 04)),
      amount: 300.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 2),
  Transaction(
      title: 'Wifi',
      description: 'Fees',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 05)),
      amount: 50.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 2),
  Transaction(
      title: 'Car Insurance',
      description: '',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 06)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.transportation,
      priority: 3),
  Transaction(
      title: 'Health Insurance',
      description: 'Insurance',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 08)),
      amount: 850.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 3),
  Transaction(
      title: 'Movie',
      description: 'Theater',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 10)),
      amount: 35.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 1),
  Transaction(
      title: 'New york eats',
      description: 'food',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 11)),
      amount: 40.00,
      transactionType: TransactionType.expense,
      category: Category.restaurant,
      priority: 1),
  Transaction(
      title: 'Income',
      description: 'Income',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 13)),
      amount: 3000.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 3),
  Transaction(
      title: 'Transportation',
      description: 'Bus & metro',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 16)),
      amount: 300.00,
      transactionType: TransactionType.expense,
      category: Category.transportation,
      priority: 2),
  Transaction(
      title: 'Chick Filla',
      description: 'Restraunt',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 18)),
      amount: 30.00,
      transactionType: TransactionType.expense,
      category: Category.restaurant,
      priority: 1),
  Transaction(
      title: 'Subway',
      description: 'Food',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 20)),
      amount: 30.00,
      transactionType: TransactionType.expense,
      category: Category.restaurant,
      priority: 1),
  Transaction(
      title: 'Mediterrean',
      description: 'Restraunt',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 24)),
      amount: 45.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 1),
  Transaction(
      title: 'Grocery',
      description: 'Shopping',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 26)),
      amount: 180.00,
      transactionType: TransactionType.expense,
      category: Category.entertainment,
      priority: 2),
  Transaction(
      title: 'Car',
      description: 'New Car',
      createdAt: fs.Timestamp.fromDate(DateTime(2021, 11, 28)),
      amount: 5000.00,
      transactionType: TransactionType.expense,
      category: Category.miscellaneous,
      priority: 1),
];
