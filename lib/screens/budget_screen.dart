import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({Key? key}) : super(key: key);

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, TextEditingController> budgetControllers = {
    'Rental': TextEditingController(),
    'Grocery': TextEditingController(),
    'Tuition': TextEditingController(),
  };
  Map<String, String> frequencySelections = {
    'Rental': 'Monthly',
    'Grocery': 'Monthly',
    'Tuition': '6-Monthly',
  };

  void _submitBudget() {
    if (_formKey.currentState!.validate()) {
      // Process the budget data.
      budgetControllers.forEach((key, controller) {
        print('$key Budget: ${controller.text} (${frequencySelections[key]})');
      });
      // Update database or state accordingly.
    }
  }

  @override
  void dispose() {
    budgetControllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> frequencyOptions = ['Monthly', '6-Monthly', 'Yearly'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: budgetControllers.keys.map<Widget>((subject) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: budgetControllers[subject],
                    decoration:
                        InputDecoration(labelText: '$subject Budget Amount'),
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a budget' : null,
                  ),
                  DropdownButton<String>(
                    value: frequencySelections[subject],
                    items: frequencyOptions
                        .map((String value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        frequencySelections[subject] = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                ],
              );
            }).toList()
              ..add(
                ElevatedButton(
                  onPressed: _submitBudget,
                  child: Text('Submit Budget'),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
