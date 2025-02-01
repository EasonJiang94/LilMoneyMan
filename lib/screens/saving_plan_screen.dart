import 'package:flutter/material.dart';

class SavingPlanScreen extends StatefulWidget {
  const SavingPlanScreen({Key? key}) : super(key: key);

  @override
  _SavingPlanScreenState createState() => _SavingPlanScreenState();
}

class _SavingPlanScreenState extends State<SavingPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController goalController = TextEditingController();
  final TextEditingController targetAmountController = TextEditingController();

  // 'Yearly' is the common way parents give money.
  String savingPlanPeriod = 'Yearly';
  List<UsageEntry> usageEntries = [
    UsageEntry(label: 'Rental', period: 'Monthly'),
    UsageEntry(label: 'Tuition', period: '6-Monthly'),
    UsageEntry(label: 'Live-Expenses', period: 'Monthly'),
    UsageEntry(label: 'Travel Fund', period: '3-Monthly'),
  ];

  void _addUsageEntry() {
    setState(() {
      usageEntries.add(UsageEntry(label: '', period: 'Monthly'));
    });
  }

  void _submitPlan() {
    if (_formKey.currentState!.validate()) {
      print('Saving Goal: ${goalController.text}');
      print('Target Amount (yearly): ${targetAmountController.text}');
      print('Plan Period: $savingPlanPeriod');
      for (var entry in usageEntries) {
        print('Usage: ${entry.label} - ${entry.period}');
      }
      // Further processing like updating a database goes here.
    }
  }

  @override
  void dispose() {
    goalController.dispose();
    targetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> planOptions = ['6-Monthly', 'Yearly'];
    List<String> withdrawalOptions = [
      'Monthly',
      '3-Monthly',
      '6-Monthly',
      'Yearly'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Saving Plan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: goalController,
                  decoration: InputDecoration(
                    labelText: 'Saving Goal (e.g. Study Abroad)',
                  ),
                  validator: (value) => (value ?? '').isEmpty
                      ? 'Please enter a saving goal'
                      : null,
                ),
                TextFormField(
                  controller: targetAmountController,
                  decoration: InputDecoration(
                    labelText: 'Target Amount Received Annually',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => (value ?? '').isEmpty
                      ? 'Please enter the target amount'
                      : null,
                ),
                DropdownButtonFormField<String>(
                  value: savingPlanPeriod,
                  decoration: InputDecoration(labelText: 'Plan Saving Period'),
                  items: planOptions
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) => setState(
                      () => savingPlanPeriod = value ?? savingPlanPeriod),
                ),
                SizedBox(height: 20),
                Text(
                  'Usage Setup',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Column(
                  children: usageEntries.asMap().entries.map((entry) {
                    int index = entry.key;
                    UsageEntry usage = entry.value;
                    return Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: usage.label,
                            decoration:
                                InputDecoration(labelText: 'Usage Label'),
                            onChanged: (val) => usage.label = val,
                            validator: (value) =>
                                (value ?? '').isEmpty ? 'Enter a usage' : null,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: usage.period,
                            decoration: InputDecoration(
                                labelText: 'Withdrawal Frequency'),
                            items: withdrawalOptions
                                .map((freq) => DropdownMenuItem<String>(
                                      value: freq,
                                      child: Text(freq),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                usage.period = value ?? usage.period;
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                TextButton(
                  onPressed: _addUsageEntry,
                  child: Text('Add Usage'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitPlan,
                  child: Text('Submit Saving Plan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UsageEntry {
  String label;
  String period;
  UsageEntry({required this.label, required this.period});
}
