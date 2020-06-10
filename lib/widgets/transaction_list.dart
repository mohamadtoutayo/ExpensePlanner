import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteHandler;

  TransactionList(this._transactions, this._deleteHandler);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            '\$${_transactions[index].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    _transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(_transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () {},
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () =>
                              _deleteHandler(_transactions[index].id),
                        ),
                ),
              );
              // return Card(
              //   child: Row(children: <Widget>[
              //     Container(
              //       margin: EdgeInsets.symmetric(
              //         vertical: 10,
              //         horizontal: 15,
              //       ),
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Theme.of(context).primaryColor,
              //           width: 2,
              //         ),
              //       ),
              //       padding: EdgeInsets.all(10),
              //       child: Text(
              //         '\$${_transactions[index].amount.toStringAsFixed(2)}',
              //         style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 20,
              //           color: Theme.of(context).primaryColor,
              //         ),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Text(
              //           _transactions[index].title,
              //           style: Theme.of(context).textTheme.headline6,
              //         ),
              //         Text(
              //           DateFormat.yMMMd().format(_transactions[index].date),
              //           style: TextStyle(
              //             color: Colors.grey,
              //           ),
              //         ),
              //       ],
              //     )
              //   ]),
              // );
            },
            itemCount: _transactions.length,
          );
  }
}
