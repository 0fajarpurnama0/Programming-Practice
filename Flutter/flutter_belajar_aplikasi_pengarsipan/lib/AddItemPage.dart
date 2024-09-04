import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _category;
  String? _description;
  double? _price;
  DateTime? _timestamp;
  final _timestampController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildNameField(),
              _buildCategoryField(),
              _buildDescriptionField(),
              _buildPriceField(),              
              _buildTimestampField(),
              _buildAddItemButton(),
            ],
                   ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
      onSaved: (value) => _name = value,
    );
  }

  Widget _buildCategoryField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Category'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a category';
        }
        return null;
      },
      onSaved: (value) => _category = value,
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Description'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a description';
        }
        return null;
      },
      onSaved: (value) => _description = value,
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a price';
        }
        return null;
      },
      onSaved: (value) => _price = double.parse(value!),
    );
  }

  Widget _buildTimestampField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Timestamp'),
      readOnly: true, // Make the field read-only
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2030),
        );
        if (date != null) {
          setState(() {
            _timestamp = date;
            // Update the text field with the selected date
            _timestampController.text = DateFormat.yMMMd().format(_timestamp!);
          });
        }
      },
      controller: _timestampController, // Add a controller to the text field
    );
  }

  Widget _buildAddItemButton() {
    return ElevatedButton(
      child: Text('Add Item'),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          final url = Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db');
          final response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': _name,
              'category': _category,
              'description': _description,
              'price': _price,
              'timestamp': _timestamp!.toIso8601String(),
            }),
          );

          if (response.statusCode == 201) {
            Navigator.pop(context); // Go back to LogisticPage
          } else {
            print('Failed to add item: ${response.statusCode}');
          }
        }
      },
    );
  }
}