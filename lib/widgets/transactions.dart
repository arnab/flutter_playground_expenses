import 'package:flutter/material.dart';

import '../data/transaction.dart';
import 'new_transaction.dart';
import 'transactions_list.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

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
      children: [
        NewTransaction(),
        TransactionList(transactions),
      ],
    );
  }
}
