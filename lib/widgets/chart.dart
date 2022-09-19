import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(this._recentTransactions, {Key? key}) : super(key: key);

  final List<Transaction> _recentTransactions;

  List<Map<String, Object>> get transactionsByDoW {
    return List.generate(7, (i) {
      final doW = DateTime.now().subtract(Duration(days: i));
      double sumForDay = _recentTransactions
          .where((tx) {
            return DateFormat.yMd().format(tx.createdAt) ==
                DateFormat.yMd().format(doW);
          })
          .map((tx) => tx.amount)
          .fold(0.0, (a, b) => a + b);

      return {
        'day': DateFormat.E().format(doW),
        'amount': sumForDay,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
