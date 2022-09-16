import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  final Function _addNewTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
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
                _addNewTransaction(
                  _titleEditingController.text,
                  double.parse(_amountEditingController.text),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
