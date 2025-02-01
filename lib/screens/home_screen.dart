import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMenuButton(context, 'Link PNC Account', '/pnc'),
            _buildMenuButton(context, 'Setup Saving Plan', '/savingPlan'),
            _buildMenuButton(context, 'Manage Budget', '/budget'),
            _buildMenuButton(context, 'My Avatar', '/avatar'),
          ],
        ),
      ),
    );
  }
}
