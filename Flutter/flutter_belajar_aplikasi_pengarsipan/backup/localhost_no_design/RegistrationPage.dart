import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _UsernameField(),
              _PasswordField(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call API to register user
                    registerUser(_username, _password);
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _UsernameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a username';
        }
        return null;
      },
      onSaved: (value) => _username = value!,
    );
  }

  Widget _PasswordField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
      onSaved: (value) => _password = value!,
    );
  }

  void registerUser(String username, String password) async {
    // Call API to register user
    final response = await http.post(
      Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_register_users_db'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Registration successful, navigate to login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      // Registration failed, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }
}