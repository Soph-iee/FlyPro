import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/models/expense_model.dart';
import 'package:flypro_expense_tracker/models/trip_model.dart';
import 'package:flypro_expense_tracker/widgets/textform_field.dart';

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  DateTime? startDate;
  DateTime? endDate;
  var _tripName = '';
  var _tripBudget = 6.0;
  var _tripDescription = '';
  var _tripDestination = '';

  //  TRIP STARTdate picker function
  Future<void> _selectStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2027),
    );
    setState(() {
      startDate = pickedDate;
    });
  }

  // TRIP END DATE
  Future<void> _selectEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2027),
    );
    setState(() {
      endDate = pickedDate;
    });
  }

  // save foem fucntion
  void _saveForm() {
    _formKey.currentState!.validate();
    if (endDate == null && startDate == null) {
      return;
    }

    _formKey.currentState!.save();
    Navigator.of(context).pop(
      Trip(
        desription: _tripDescription,
        budget: _tripBudget,
        name: _tripName,
        destination: _tripDestination,
        endDate: endDate!,
        startDate: startDate!,
        currency: Currency.ngn,
        expenseCount: 0,
        status: 'active',
        totalSpent: 0,
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputTextField(
                onSaved: (value) {
                  _tripName = value!;
                },
                inputText: 'Trip name',
                errorMsg: 'please enter your trip name',
              ),

              InputTextField(
                onSaved: (value) {
                  _tripDestination = value!;
                },
                inputText: 'Destination',
                errorMsg: 'Please, enter your trip destination',
              ),
              InputTextField(
                onSaved: (value) {
                  _tripBudget = double.parse(value!);
                },
                inputText: 'Trip budget',
                errorMsg: 'Please input yout trip budget',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
              Row(
                children: [
                  startDate == null
                      ? Expanded(
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Pick Start Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _selectStartDate,
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              size: 24,
                            ),
                          ),
                        )
                      : Text(
                          '${startDate!.day} / ${startDate!.month} / ${startDate!.year} ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                  const SizedBox(
                    width: 16,
                  ),
                  endDate == null
                      ? Expanded(
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Pick End Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _selectEndDate,
                            icon: const Icon(
                              Icons.calendar_month_rounded,
                              size: 24,
                            ),
                          ),
                        )
                      : Text(
                          '${endDate!.day} / ${endDate!.month} / ${endDate!.year} ',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ],
              ),
              InputTextField(
                inputText: 'Trip description',
                errorMsg: 'please, enter trip description here',

                onSaved: (value) {
                  _tripDescription = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
