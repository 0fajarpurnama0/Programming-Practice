import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item Page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addItem,
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _addItem() async {
    final name = _nameController.text;
    final category = _categoryController.text;
    final description = _descriptionController.text;
    final price = _priceController.text;
    final timestamp = DateTime.now().toIso8601String();

    final url = Uri.parse('http://localhost:3000/items');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'category': category,
        'description': description,
        'price': price,
        'timestamp': timestamp,
      }),
    );

    if (response.statusCode == 201) {
      Navigator.of(context).pop();
    } else {
      print('Failed to add item');
    }
  }
}