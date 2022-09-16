import 'package:flutter/material.dart';
import 'package:flutter_playground_expenses_app/widgets/transactions_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses App'),
      ),
      body: Column(
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
          Card(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleEditingController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Amount'),
                    controller: _amountEditingController,
                  ),
                  TextButton(
                    onPressed: () {
                      print('Title: ${_titleEditingController.text} and Amount: ${_amountEditingController.text}');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.purple,
                    ),
                    child: const Text('Add Transaction'),
                  ),
                ],
              ),
            ),
          ),
          TransactionList(),
        ],
      ),
    );
  }
}
