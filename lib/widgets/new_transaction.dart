import 'package:flutter/material.dart';
import '../widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';

// In a statefulwidget you have a split into 2 classes, in the first Flutter creates a state object
// The state object is an independent object managed in memory. Widget holds a reference to the state object
class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

// life cycle methods can improve performance. You add them to the state
class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

// initState is implemented by State where we inherit it from,
// it is often used to load some data from a database or do an http request
// with @override we say that we deliberately want to use our own
  @override
  void initState() {
// super is a keyword in Dart that refers to the parent class:
// it refers to the parent object (State) and makes sure that we also call initState (of State) there
    print('initState NewTransaction Widget');
    super.initState();
  }

// Here you take the old widget as property to fi compare it to the new widget
// It can be used when your data from the db is changed, fi a new id
  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget NewTransaction Widget');
    super.didUpdateWidget(oldWidget);
  }

// called when a widget is removed, great for cleaning up data
// fi when you have a chat application, you can clean up the connection
// to the server when your widget is removed, cleaning up listeners etc you do here
  @override
  void dispose() {
    print('dispose NewTransaction Widget');
    super.dispose();
  }

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
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // This code tells how much space is occupied by the keyboard (or other inset object)
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
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
                    AdaptiveFlatButton('Choose date', _presentDatePicker)
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
      ),
    );
  }
}
