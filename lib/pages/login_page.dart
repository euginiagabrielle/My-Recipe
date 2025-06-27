import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_c14220050/auth/auth_service.dart';
import 'package:uas_c14220050/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _myAuth = Hive.box('myAuth');
  
  void writeData() {
    _myAuth.put(1, 'authenticated');
  }

  bool readData() {
    debugPrint(_myAuth.get(1));
    if (_myAuth.get(1)) { return true; }
    else { return false; }
  }

  void deleteData() {
    _myAuth.delete(1);
  }

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  void login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      await authService.signInWithEmailPassword(email, password);
      writeData();
    } catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email or password doesn't match")));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(title: const Text("Login", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.amber[100], centerTitle: true),
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
          const SizedBox(height: 12),
          ElevatedButton(onPressed: login, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[300],
              foregroundColor: Colors.black
            ),
            child: const Text("Login")
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => const RegisterPage()),
            ),
            child: Center(
              child: Text("Don't have an account? Sign Up",
              style: TextStyle(
                color: Colors.black,
              ),)),
          )
        ],
      ),
    );
  }
}