import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_c14220050/auth/auth_gate.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("🍳 My Recipes 🍳\nSave your recipes now, make it easier to recall.", 
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center
              ),
              const SizedBox(height: 20),
              Text("Get started and create your first recipe!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: () async {
                final box = Hive.box('myAuth');
                await box.put('isFirstTime', false);
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => const AuthGate()),
                );
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[300],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(fontSize: 18),
              ))
            ],
          ),
        ),
      ),
    );
  }
}