import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_c14220050/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_c14220050/pages/get_started_page.dart';

void main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('myAuth');
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF2b3hhbHN2aXhnaHJuc3ZlaXFvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA4MzI4NjAsImV4cCI6MjA2NjQwODg2MH0.yb9X8a1k5wcyoSbKVE8uOWw23QtFtdrkHjEuR1IgB28",
    url: "https://avoxalsvixghrnsveiqo.supabase.co",
  );
  final isFirstTime = box.get('isFirstTime', defaultValue: true);
  runApp(MainApp(isFirstTime: isFirstTime));
}

class MainApp extends StatelessWidget {
  final  bool isFirstTime;
  const MainApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isFirstTime ? const GetStartedPage() : const AuthGate(),
    );
  }
}
