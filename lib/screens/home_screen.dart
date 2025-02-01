import 'package:flutter/material.dart';
import '../screens/saving_plan_screen.dart'; // to access currentSavingPlanData

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildDashboard() {
    if (currentSavingPlanData == null) {
      return Text('No saving plan set up yet.');
    }
    final plan = currentSavingPlanData!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Saving Plan Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('Remaining Balance'),
            subtitle: Text('\$${plan.remainingBalance.toStringAsFixed(2)}'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Accumulated Interest'),
            subtitle: Text('\$${plan.accumulatedInterest.toStringAsFixed(2)}'),
          ),
        ),
        SizedBox(height: 10),
        Text('Usage Withdrawals:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        ...plan.usageEntries.map((usage) {
          return Card(
            child: ListTile(
              leading: Icon(Icons.money_off),
              title: Text(usage.label),
              subtitle:
                  Text('Total Withdrawn: \$${usage.amount.toStringAsFixed(2)}'),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () => Navigator.pushNamed(context, '/chat'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildMenuButton(context, 'Link PNC Account', '/pnc'),
              _buildMenuButton(context, 'Setup Saving Plan', '/savingPlan'),
              _buildMenuButton(context, 'My Avatar', '/avatar'),
              SizedBox(height: 20),
              _buildDashboard(),
            ],
          ),
        ),
      ),
    );
  }
}
