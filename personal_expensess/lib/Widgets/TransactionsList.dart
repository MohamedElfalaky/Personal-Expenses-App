import 'package:flutter/material.dart';
import 'package:personal_expensess/Models/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> theList;
  Function deletee;
  TransactionList(this.theList, this.deletee);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 300,
      child: theList.isEmpty
          ? Image.asset('images/favorites3.png')
          : Container(
              height: 400,
              child: ListView(
                children: theList.map((e) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(child: Text("\$${e.amount}")),
                        ),
                      ),
                      title: Text("${e.title}"),
                      subtitle: Text(
                        DateFormat.yMMMd().format(e.date),
                      ),
                      trailing: IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => deletee(e.id),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
    );
  }
}
