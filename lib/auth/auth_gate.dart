import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_c14220050/pages/list_recipe_page.dart';
import 'package:uas_c14220050/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final _myAuth = Hive.box('myAuth');
  void writeData() {
    _myAuth.put(1, 'authenticated');
  }

  String? readData() {
    return _myAuth.get(1);
  }

  void deleteData() {
    _myAuth.delete(1);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;
        if (session != null && readData() != null) {
          return ListRecipePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}