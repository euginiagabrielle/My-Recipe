import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
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

  // sign in
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // sign up
  Future<AuthResponse> signUpWithEmailPassword(
    String email,
    String password,
  ) async {
    return await _supabase.auth.signUp(
      email: email,
      password: password
    );
  }

  // sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
    deleteData();
  }

  // get user email
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
}