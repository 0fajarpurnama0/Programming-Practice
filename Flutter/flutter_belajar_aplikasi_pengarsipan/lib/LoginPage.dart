import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CashierPage.dart';
import 'GuestPage.dart';
import 'LogisticPage.dart';
import 'RegistrationPage.dart';
import 'AdminPage.dart';
import 'UsersPage.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _login(context, 'HomePage'),
                  child: Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to registration page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()),
                    );
                  },
                  child: Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () => _login(context, 'UsersPage'),
                  child: Text('Users'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context, String DestinationPage) async {
    final credentials = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };
    final response = await http.post(
      Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_user_db'),
      body: json.encode(credentials),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 && json.decode(response.body)['success']) {
      final userRole = json.decode(response.body)['role'];
      if(DestinationPage == "HomePage") {
        if(userRole == "cashier"){
          ToCashierPage(context);
        } else if(userRole == "logistic") {
          ToLogisticPage(context);
        } else if(userRole == "admin") {
          ToAdminPage(context);
        } else {
          ToGuestPage(context);
        }
      } else if (DestinationPage == "UsersPage" && userRole == "superadmin") {
        ToUsersPage(context);
      } else {
        SnackBar(content: Text('Something went wrong'));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }
}

void ToGuestPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => GuestPage()),);
}

void ToCashierPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => CashierPage()),);
}

void ToLogisticPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LogisticPage()),);
}

void ToAdminPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()),);
}

void ToUsersPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => UsersPage()),);
}