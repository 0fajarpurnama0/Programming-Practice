import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class EditItemScreen extends StatefulWidget {
  final int itemId;
  EditItemScreen({required this.itemId});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchItem();
  }

  void _fetchItem() async {
    final response = await http
        .get(Uri.parse('http://localhost:3000/items/${widget.itemId}'));

    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      setState(() {
        _nameController.text = item['name'];
        _categoryController.text = item['category'];
        _descriptionController.text = item['description'];
        _priceController.text = item['price'].toString();
      });
    } else {
      print('Failed to load item');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
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
              onPressed: _editItem,
              child: Text('Save'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _deleteItem,
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteItem() async {
    final id = widget.itemId;

    final url = Uri.parse('http://localhost:3000/items/$id');

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Item deleted successfully');

      Navigator.of(context).pop();
    } else {
      print('Failed to delete item');
    }
  }

  void _editItem() async {
    final name = _nameController.text;
    final category = _categoryController.text;
    final description = _descriptionController.text;
    final price = _priceController.text;

    final url = Uri.parse('http://localhost:3000/items/${widget.itemId}');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'category': category,
        'description': description,
        'price': price,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    } else {
      print('Failed to update item');
    }
  }
}