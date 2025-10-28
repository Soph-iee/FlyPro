import 'package:flutter/material.dart';
import 'package:flypro_expense_tracker/components/textform_field.dart';

class NewTrip extends StatefulWidget {
  const NewTrip({super.key});

  @override
  State<NewTrip> createState() => _NewTripState();
}

class _NewTripState extends State<NewTrip> {
  DateTime? startDate;
  DateTime? endDate;

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Trip'),
        actions: [
          TextButton.icon(
            onPressed: () {},
            label: const Text('Save'),
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const InputTextField(
                inputText: 'Trip name',
                errorMsg: 'please enter your trip name',
              ),
              const InputTextField(
                inputText: 'Destination',
                errorMsg: 'Please, enter your trip destination',
              ),
              const InputTextField(
                inputText: 'Trip budget',
                errorMsg: 'Please input yout trip budget',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                children: [
                  startDate == null
                      ? Expanded(
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Pick Date',
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
                              'Pick Date',
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
              const InputTextField(
                inputText: 'Trip description',
                errorMsg: 'please, enter trip description here',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data submitted')),
                      );
                    }
                  },
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
