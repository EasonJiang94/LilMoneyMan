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
            const SizedBox(height: 50),
             SizedBox (
              width: 200,
              height: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Create\nAccount',
              style: TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(0, 118, 81, 0.667),
                fontFamily: 'Jersey25',
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 50),
            SizedBox (
              width: 200,
              height: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text('Log In',
              style: TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(0, 118, 81, 0.667),
                fontFamily: 'Jersey25',
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 50),
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
