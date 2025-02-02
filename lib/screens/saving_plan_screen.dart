import 'package:flutter/material.dart';

// For demo purposes, we store the saving plan globally.
SavingPlanData? currentSavingPlanData;

class SavingPlanData {
  double yearlyDeposit;
  String planPeriod;
  List<UsageEntry> usageEntries;
  SavingPlanData({
    required this.yearlyDeposit,
    required this.planPeriod,
    required this.usageEntries,
  });

  double get totalUsage =>
      usageEntries.fold(0, (sum, entry) => sum + entry.amount);
  double get remainingBalance => yearlyDeposit - totalUsage;
  double get accumulatedInterest {
      // 4% annual interest rate, compounded monthly (0.3274% per month)
      const double monthlyRate = 0.003274; // 0.3274% = 4% / 12
      //double balance = yearlyDeposit - totalUsage; // 一开始存入存款 = yearlyDeposit - totalUsage
      double balance = yearlyDeposit - totalUsage;
      double interest = 0.0;

      // 1️⃣ **开始 11 个月的循环，每月计算利息并按周期取出**
      for (int month = 1; month < 12; month++) {
          // 计算当前余额的利息
          interest += balance * monthlyRate;

          // 按周期取出资金
          for (var entry in usageEntries) {
              if ((entry.period == 'Monthly') || 
                  (entry.period == '3-Monthly' && month % 3 == 0) ||
                  (entry.period == '6-Monthly' && month % 6 == 0)) {
                  balance -= entry.amount; // 取出资金
              }
          }

          if (balance < 0) balance = 0;
      }

      return interest;
  }
}

class UsageEntry {
  String label;
  String period;
  double amount;
  UsageEntry({required this.label, required this.period, this.amount = 0.0});
}

class SavingPlanScreen extends StatefulWidget {
  const SavingPlanScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SavingPlanScreenState createState() => _SavingPlanScreenState();
}

class _SavingPlanScreenState extends State<SavingPlanScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController depositController = TextEditingController();

  // Plan period: 'Yearly' or '6-Monthly'
  String planPeriod = 'Yearly';

  List<UsageEntry> usageEntries = [
    UsageEntry(label: 'Rental', period: 'Monthly', amount: 0.0),
    UsageEntry(label: 'Tuition', period: '6-Monthly', amount: 0.0),
    UsageEntry(label: 'Live-Expenses', period: 'Monthly', amount: 0.0),
    UsageEntry(label: 'Travel Fund', period: '3-Monthly', amount: 0.0),
  ];

  void _addUsageEntry() {
    setState(() {
      usageEntries.add(UsageEntry(label: '', period: 'Monthly'));
    });
  }

  void _submitPlan() {
    if (_formKey.currentState!.validate()) {
      final double deposit = double.tryParse(depositController.text) ?? 0.0;
      currentSavingPlanData = SavingPlanData(
        yearlyDeposit: deposit,
        planPeriod: planPeriod,
        usageEntries: usageEntries,
      );
      print('Submitted Saving Plan:');
      print('Deposit: \$${deposit}');
      print('Plan Period: $planPeriod');
      usageEntries.forEach((entry) {
        print(
            'Usage: ${entry.label}, Amount: \$${entry.amount}, Frequency: ${entry.period}');
      });
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void dispose() {
    depositController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> planOptions = ['6-Monthly', 'Yearly'];
    List<String> frequencyOptions = [
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
                  controller: depositController,
                  decoration: InputDecoration(
                    labelText: 'Yearly Deposit (from parents)',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      (value ?? '').isEmpty ? 'Enter deposit amount' : null,
                ),
                DropdownButtonFormField<String>(
                  value: planPeriod,
                  decoration: InputDecoration(labelText: 'Plan Saving Period'),
                  items: planOptions
                      .map((option) => DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => planPeriod = value ?? planPeriod),
                ),
                SizedBox(height: 20),
                Text('Usage Setup',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Column(
                  children: usageEntries.asMap().entries.map((entry) {
                    int index = entry.key;
                    UsageEntry usage = entry.value;
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Usage ${index + 1}',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextFormField(
                              initialValue: usage.label,
                              decoration:
                                  InputDecoration(labelText: 'Usage Label'),
                              onChanged: (val) => usage.label = val,
                              validator: (value) => (value ?? '').isEmpty
                                  ? 'Enter usage label'
                                  : null,
                            ),
                            TextFormField(
                              initialValue: usage.amount != 0.0
                                  ? usage.amount.toString()
                                  : '',
                              decoration: InputDecoration(
                                  labelText: 'Allocated Amount'),
                              keyboardType: TextInputType.number,
                              onChanged: (val) =>
                                  usage.amount = double.tryParse(val) ?? 0.0,
                              validator: (value) => (value ?? '').isEmpty
                                  ? 'Enter allocated amount'
                                  : null,
                            ),
                            DropdownButtonFormField<String>(
                              value: usage.period,
                              decoration: InputDecoration(
                                  labelText: 'Withdrawal Frequency'),
                              items: frequencyOptions
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
                          ],
                        ),
                      ),
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
