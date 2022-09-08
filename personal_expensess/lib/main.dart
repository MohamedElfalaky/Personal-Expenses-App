import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:personal_expensess/Widgets/Chart.dart';
import 'package:personal_expensess/Widgets/New_transaction.dart';
import 'package:personal_expensess/Widgets/TransactionsList.dart';
import 'dart:math';

import './Models/Transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.amber,
          fontFamily: "OpenSans"),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(title: "Shoes", id: "1", amount: 2.5, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: date,
        id: Random().nextDouble().toString());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 10; i++) {
    //   print(Random().nextDouble());
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Chart(_recentTransactions),
            ),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return GestureDetector(
                  onTap: () {},
                  behavior: HitTestBehavior.opaque,
                  child: NewTransaction(_addNewTransaction));
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
