import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  final Function _addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditingController = TextEditingController();

  final _amountEditingController = TextEditingController();

  void submitTransaction() {
    final title = _titleEditingController.text;
    final amount = double.parse(_amountEditingController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget._addNewTransaction(title, amount);
    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountEditingController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitTransaction(),
            ),
            TextButton(
              onPressed: submitTransaction,
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
