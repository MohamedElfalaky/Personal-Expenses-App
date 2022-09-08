import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNew;
  NewTransaction(this.addNew);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void submitData() {
    if (titleController.text.isEmpty ||
        double.parse(amountController.text) <= 0 ||
        _selectedDate == null) {
      return;
    }
    widget.addNew(titleController.text, double.parse(amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void _PresenDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Title"),
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(labelText: "Amount"),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? "No date chosen!"
                    : 'Picked Date is: ${DateFormat.yMd().format(_selectedDate!)}'),
                TextButton(
                    onPressed: _PresenDatePicker,
                    child: Text("Choose Date"),
                    style: TextButton.styleFrom(primary: Colors.purple))
              ],
            ),
            TextButton(
              onPressed: submitData,
              child: Text("Add Transaction"),
              style: TextButton.styleFrom(primary: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}
