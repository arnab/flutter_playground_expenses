import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

import '../data/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, this._deleteTransaction, {Key? key})
      : super(key: key);

  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    _transactions.sort((t1, t2) => t2.createdAt.compareTo(t1.createdAt));
    return SizedBox(
      height: 700,
      child: _transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'Please add some transactions!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
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
                            Money.fromNum(tx.amount, code: 'CAD')
                                .format('S0.00'),
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
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            icon: const Icon(Icons.delete),
                            style: TextButton.styleFrom(
                              foregroundColor: Theme.of(context).colorScheme.error
                            ),
                            label: const Text('Delete'),
                            onPressed: () => _deleteTransaction(tx.id),
                          )
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).colorScheme.error,
                            onPressed: () => _deleteTransaction(tx.id),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
