
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';

import '../data/transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  final List<Transaction> transactions = [
    Transaction(
        id: 'T1', title: 'Shoes', amount: 129.99, createdAt: DateTime.now()),
    Transaction(
        id: 'T2', title: 'Grocery', amount: 84.38, createdAt: DateTime.now()),
    Transaction(
        id: 'T3', title: 'Udemy', amount: 120.00, createdAt: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((tx) {
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
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
                child: Text(
                  Money.fromNum(tx.amount, code: 'CAD').format('S0.00'),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
      }).toList(),
    );
  }
}
