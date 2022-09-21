import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'data/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenszy',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ).copyWith(
              secondary: Colors.amber,
          ),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                titleMedium: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                titleSmall: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                ),
              ),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ))),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _uuid = const Uuid();

  final List<Transaction> _transactions = [
    Transaction(
        id: const Uuid().v4(),
        title: 'Tennis Classes',
        amount: 730.00,
        createdAt: DateTime.parse('2022-09-15')),
    Transaction(
        id: const Uuid().v4(),
        title: 'Tennis Racket',
        amount: 227.99,
        createdAt: DateTime.parse('2022-09-17')),
    Transaction(
        id: const Uuid().v4(),
        title: 'Clove Restaurant',
        amount: 227.99,
        createdAt: DateTime.parse('2022-09-18')),
    Transaction(
        id: const Uuid().v4(),
        title: 'Grocery',
        amount: 68.72,
        createdAt: DateTime.parse('2022-09-19')),
    Transaction(
        id: const Uuid().v4(),
        title: 'Starbucks',
        amount: 6.72,
        createdAt: DateTime.parse('2022-09-20')),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.createdAt.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      createdAt: date,
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenszy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              child: Chart(_recentTransactions),
            ),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
