import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
// every item in Flutter can have a key, but most widgets don't need that key,
//   especially stateless widgets
    Key key,
    @required this.transaction,
    @required this.deleteTx,
// by calling super you are instantiating the parent class, and you only
//   have to do it when you want to pass some extra data to the parent class
// special notation of Dart for calling the superconstructor: constructor initializer list
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
// if I want to change a property in every instance of a widget then I can use the key property
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          foregroundColor: Colors.white,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline1,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
// default errorColor = red so you don't have to set it in the theme
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.delete, color: Colors.grey),
              )
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: const Icon(Icons.delete),
                color: Colors.grey,
              ),
      ),
    );
  }
}
