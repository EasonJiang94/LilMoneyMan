import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 164, 119),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Lil Money Man',
              style: TextStyle(
                fontSize: 64,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Jersey25',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Create Account\nor\nLog In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Jersey25',
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Continue'),
            ),
            const SizedBox(height: 40),
            Image.asset(
              'assets/avatars/buddy.png', // Update with your image path
              width: 450,
            ),
          ],
        ),
      ),
    );
  }
}
