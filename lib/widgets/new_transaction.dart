import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

// with the widget.addTx I can access the Class that's related to the State class
// it is only available in your state classes
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
// This closes the modal by popping it off
    Navigator.of(context).pop();
  }

// this is a future function is asyncronized so statements after the then are still immediately executed
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      // setState tells Flutter that a statefull widget is updated and that build should run again
      setState(() {
        _selectedDate = pickedDate;
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
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: Theme.of(context).textTheme.headline2,
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: Theme.of(context).textTheme.headline2,
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
// the _ means I get a value, but I am not doing anything with it
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Choose date',
                      style: Theme.of(context).textTheme.button,
                    ),
// without parethesis, we just want to pass a reference to the method
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text(
                'Add transaction',
              ),
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}
