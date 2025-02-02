import 'package:flutter/material.dart';
import 'package:tmp/services/fake_google_sign_in.dart'; // Update with your package name if needed

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _handleGoogleSignIn() async {
    try {
      await _googleSignIn.signIn();
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home');
    } catch (error) {
      print('Failed to sign in with Google: $error');
    }
  }

  void _handleEmailSignIn() {
    if (_formKey.currentState!.validate()) {
      print('Username/Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      // Normally, add your authentication logic here.
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Username/Email',
                ),
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your email'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Please enter your password'
                    : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _handleEmailSignIn,
                child: const Text('Sign in',
                style: TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(0, 118, 81, 0.667),
                fontFamily: 'Jersey25',
                    ),
                  ),
              ),
              const SizedBox(height: 16),
              const Text('or'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _handleGoogleSignIn,
                child: const Text('Sign in with Google',
                style: TextStyle(
                fontSize: 35,
                color: Color.fromRGBO(0, 118, 81, 0.667),
                fontFamily: 'Jersey25',
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
