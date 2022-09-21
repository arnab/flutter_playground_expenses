import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

import '../data/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, {Key? key}) : super(key: key);

  final List<Transaction> _transactions;

  @override
  Widget build(BuildContext context) {
    _transactions.sort((t1, t2) => t2.createdAt.compareTo(t1.createdAt));
    return SizedBox(
      height: 500,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'Please add some transactions!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 25),
                SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, i) {
                final tx = _transactions[i];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            Money.fromNum(tx.amount, code: 'CAD').format('S0.00'),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tx.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(tx.createdAt),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
