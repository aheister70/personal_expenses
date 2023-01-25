import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
// SizedBox is often used as separator between widgets
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return TransactionItem(
                    key: ValueKey<String>(transactions[index].id),
                    transaction: transactions[index],
                    deleteTx: deleteTx,
                  );
                },
                childCount: transactions.length,
                findChildIndexCallback: (Key key) {
                  final ValueKey<String> valueKey = key as ValueKey<String>;
                  final String data = valueKey.value;
                  return transactions.indexWhere((el) => el.id == data);
                }),
          );
  }
}


  //           ListView.builder(
  //           itemBuilder: (ctx, index) {
  //             return TransactionItem(
  //                 transaction: transactions[index], deleteTx: deleteTx);
  //           },
  //           itemCount: transactions.length,
  //         );
  // }
//}