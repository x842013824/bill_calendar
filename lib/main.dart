import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widghts/chart_card.dart';
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

  List<Transaction> get _recentTransations {
    final lastDate = DateTime.now().subtract(const Duration(days: 7));
    return _transactions.where((tx) {
      return tx.date.isAfter(lastDate);
    }).toList();
  }

  void _addTransaction(({String title, double amount, DateTime date}) record) {
    final transaction = Transaction(
      uid: DateTime.now().toString(),
      title: record.title,
      amount: record.amount,
      date: record.date,
    );

    setState(() => _transactions.add(transaction));
  }

  void _deleteTransaction(String uid) {
    setState(() {
      _transactions.removeWhere((tx) => tx.uid == uid);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    _scaffoldKey.currentState!.showBottomSheet(
        (context) => NewTransaction(_addTransaction),
        enableDrag: true);
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Bill Calendar';

    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);

    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          titleTextStyle: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: colorScheme.onPrimary,
            size: 32,
          ),
        ),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text(title),
          // centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => _startAddNewTransaction(context),
              icon: const Icon(Icons.add),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            ChartCard(_recentTransations),
            TransactionList(
              data: _transactions,
              onDelete: _deleteTransaction,
            ),
          ],
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
