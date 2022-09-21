import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  final Function _addNewTransaction;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitTransaction() {
    if (_amountEditingController.text.isEmpty) {
      return;
    }

    final title = _titleEditingController.text;
    final amount = double.parse(_amountEditingController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    widget._addNewTransaction(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        _selectedDate = date;
      });
    });
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
              onSubmitted: (_) => _submitTransaction(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountEditingController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitTransaction(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate)),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitTransaction,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
