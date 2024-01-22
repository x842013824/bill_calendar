import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widghts/new_transaction.dart';
import './widghts/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [
    Transaction(
      uid: '1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      uid: '2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _addTransaction(({String title, double amount}) record) {
    final transaction = Transaction(
      uid: DateTime.now().toString(),
      title: record.title,
      amount: record.amount,
      date: DateTime.now(),
    );

    setState(() => _transactions.add(transaction));
  }

  void _startAddNewTransaction(BuildContext context) {
    _scaffoldKey.currentState!.showBottomSheet(
        (context) => NewTransaction(_addTransaction),
        enableDrag: true);
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Bill Calendar';

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeData().colorScheme.primary,
          titleTextStyle: TextStyle(
            color: ThemeData().colorScheme.onPrimary,
            fontSize: 24,
          ),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: const Text(title), actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ]),
        body: Column(
          children: [TransactionList(_transactions)],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
