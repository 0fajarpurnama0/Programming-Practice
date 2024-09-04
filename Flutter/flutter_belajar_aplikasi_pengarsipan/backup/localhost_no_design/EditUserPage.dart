import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> user;
  final Function()? onSaved; // Add a callback function

  EditUserPage({required this.user, this.onSaved});

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              value: _selectedRole,
              onChanged: (value) => setState(() => _selectedRole = value as String?),
              items: [
                'admin',
                'logistic',
                'cashier',
                'guest',
              ].map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              )).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                // Update user role in database
                await updateUserRole(widget.user, _selectedRole);
                if (widget.onSaved != null) {
                  widget.onSaved!(); // Call the callback function
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUserRole(Map<String, dynamic> user, String? role) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_update_user_role'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'role': role, 'username': user['username']}),
      );
      if (response.statusCode == 200) {
        print('User role updated successfully');
      } else {
        print('Error updating user role: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating user role: $e');
    }
  }
}