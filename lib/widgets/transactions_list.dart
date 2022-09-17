import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

import '../data/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, {Key? key}) : super(key: key);

  final List<Transaction> _transactions;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: _transactions.length,
        itemBuilder: (ctx, i) {
          final tx = _transactions[i];
          return Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    Money.fromNum(tx.amount, code: 'CAD').format('S0.00'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      DateFormat.yMMMEd().format(tx.createdAt),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
