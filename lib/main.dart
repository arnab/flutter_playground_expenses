import 'package:flutter/material.dart';
import 'package:flutter_playground_expenses_app/widgets/new_transaction.dart';
import 'package:uuid/uuid.dart';

import 'data/transaction.dart';
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
            primarySwatch: Colors.purple
        ).copyWith(
            secondary: Colors.amber
        )
      ),
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
        id: 'T1', title: 'Shoes', amount: 129.99, createdAt: DateTime.now()),
    Transaction(
        id: 'T2', title: 'Grocery', amount: 84.38, createdAt: DateTime.now()),
    Transaction(
        id: 'T3', title: 'Udemy', amount: 120.00, createdAt: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final tx = Transaction(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      createdAt: DateTime.now(),
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
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
              child: const Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Chart Area'),
              ),
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
