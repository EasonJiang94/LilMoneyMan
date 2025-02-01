import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/pnc_account_screen.dart';
import 'screens/saving_plan_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/avatar_screen.dart';

void main() {
  runApp(BankFinancialApp());
}

class BankFinancialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Financial Suggestion App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/pnc': (context) => PNCAccountScreen(),
        '/savingPlan': (context) => SavingPlanScreen(),
        '/budget': (context) => BudgetScreen(),
        '/chat': (context) => ChatbotScreen(),
        '/avatar': (context) => AvatarScreen(),
      },
    );
  }
}
