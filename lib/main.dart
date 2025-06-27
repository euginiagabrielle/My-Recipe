import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_c14220050/auth/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uas_c14220050/pages/get_started_page.dart';

void main() async {
  await Hive.initFlutter();
  final box = await Hive.openBox('myAuth');
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    anonKey: dotenv.env['SUPABASE_ANONKEY']!,
    url: dotenv.env['SUPABASE_URL']!,
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
