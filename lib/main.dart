import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'data/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transactions_list.dart';

void main() {
  // Disable landscape mode:
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var primaryColor = Colors.purple;
    var primaryColorAccent = Colors.purpleAccent;
    var secondaryColor = Colors.pink;

    return MaterialApp(
      title: 'Expenszy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primaryColor,
        ).copyWith(
          secondary: secondaryColor,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              titleSmall: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 14,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(primaryColor),
          trackColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? primaryColorAccent
                  : null),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _uuid = const Uuid();
  var _showChartSwitchState = false;

  final List<Transaction> _transactions = [
    Transaction(
      id: const Uuid().v4(),
      title: 'Tennis Classes',
      amount: 55.00,
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Tennis Racket',
      amount: 127.99,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Weekend Brunch with Friends',
      amount: 123.99,
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Grocery',
      amount: 68.72,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: const Uuid().v4(),
      title: 'Starbucks',
      amount: 6.72,
      createdAt: DateTime.now(),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.createdAt.isAfter(
        DateTime.now().subtract(const Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final tx = Transaction(
      id: _uuid.v4(),
      title: title,
      amount: amount,
      createdAt: date,
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = (Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Expenszy'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: const Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: const Text('Expenszy'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          )) as ObstructingPreferredSizeWidget;

    var mediaQuery = MediaQuery.of(context);
    final heightBelowAppBar = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final landscapeMode = mediaQuery.orientation == Orientation.landscape;
    final portraitMode = !landscapeMode;
    final showTransactions =
        portraitMode || (landscapeMode && !_showChartSwitchState);
    final showChart = portraitMode || (landscapeMode && _showChartSwitchState);
    final chartHeightPct = landscapeMode ? 0.6 : 0.3;
    final transactionsListHeightPct =
        landscapeMode ? 0.6 : (1 - chartHeightPct);

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (landscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChartSwitchState,
                    onChanged: (val) {
                      setState(() {
                        _showChartSwitchState = val;
                      });
                    },
                  ),
                ],
              ),
            if (showChart)
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: heightBelowAppBar * chartHeightPct,
                  child: Chart(_recentTransactions),
                ),
              ),
            if (showTransactions)
              SizedBox(
                height: heightBelowAppBar * transactionsListHeightPct,
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
