import 'dart:io';

void main() {
  final baseDir = Directory('lib');
  final directories = [
    'lib/screens',
    'lib/widgets',
  ];
  final files = {
    'lib/main.dart': """
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
""",
    'lib/screens/login_screen.dart': """import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login Screen')),
    );
  }
}
""",
    'lib/screens/home_screen.dart': """import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Screen')),
    );
  }
}
""",
    'lib/screens/pnc_account_screen.dart': """import 'package:flutter/material.dart';

class PncAccountScreen extends StatelessWidget {
  const PncAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PNC Account')),
      body: const Center(child: Text('PNC Account Screen')),
    );
  }
}
""",
    'lib/screens/saving_plan_screen.dart': """import 'package:flutter/material.dart';

class SavingPlanScreen extends StatelessWidget {
  const SavingPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saving Plan')),
      body: const Center(child: Text('Saving Plan Screen')),
    );
  }
}
""",
    'lib/screens/budget_screen.dart': """import 'package:flutter/material.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: const Center(child: Text('Budget Screen')),
    );
  }
}
""",
    'lib/screens/chatbot_screen.dart': """import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chatbot')),
      body: const Center(child: Text('Chatbot Screen')),
    );
  }
}
""",
    'lib/screens/avatar_screen.dart': """import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avatar')),
      body: const Center(child: Text('Avatar Screen')),
    );
  }
}
""",
    'lib/widgets/custom_drawer.dart': """import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
""",
  };

  // Create directories
  for (var dir in directories) {
    Directory(dir).createSync(recursive: true);
  }

  // Create files with content
  files.forEach((path, content) {
    File(path).writeAsStringSync(content);
  });

  print('Flutter project structure created successfully.');
}
