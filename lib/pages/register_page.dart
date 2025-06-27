import 'package:flutter/material.dart';
import 'package:uas_c14220050/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password don't match")));
      return;
    }

    try {
      await authService.signUpWithEmailPassword(email, password);
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
        return;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(title: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.amber[100], centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 50),
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )
            ),
            cursorColor: Colors.black,
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )
            ),
            cursorColor: Colors.black,
            obscureText: true,
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: "Confirm password",
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              )
            ),
            cursorColor: Colors.black,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: signUp, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[300],
              foregroundColor: Colors.black
            ),
            child: const Text("Sign Up")
          )
        ],
      ),
    );
  }
}