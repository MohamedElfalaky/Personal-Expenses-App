import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spengingPct;

  const Bar(
    this.lable,
    this.spendingAmount,
    this.spengingPct,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      child: Column(
        children: [
          Text("\$${spendingAmount.toStringAsFixed(0)}"),
          Container(
            height: 100,
            width: 20,
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(decoration: BoxDecoration(color: Colors.green)),
                FractionallySizedBox(
                  heightFactor: spengingPct,
                  child: Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor)),
                )
              ],
            ),
          ),
          Text("${lable}")
        ],
      ),
    );
  }
}
