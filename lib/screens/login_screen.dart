import 'package:flutter/material.dart';
import 'package:tmp/services/fake_google_sign_in.dart'; // Update with your package name

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // After successful login, navigate to the HomeScreen.
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Failed to sign in with Google: $error');
      // Handle error appropriately.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleGoogleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}
