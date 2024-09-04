import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdminEditItemPage extends StatefulWidget {
  final Map<String, dynamic> item;

  AdminEditItemPage({required this.item});

  @override
  _AdminEditItemPageState createState() => _AdminEditItemPageState();
}

class _AdminEditItemPageState extends State<AdminEditItemPage> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _category;
  String? _description;
  double? _price;
  DateTime? _timestamp;
  final _timestampController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _name = widget.item['name'];
    _category = widget.item['category'];
    _description = widget.item['description'];
    _price = double.parse(widget.item['price']);
    _timestamp = DateTime.parse(widget.item['timestamp']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
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
              _buildSaveButton(),
              _buildDeleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      initialValue: _name,
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
      initialValue: _category,
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
      initialValue: _description,
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
      initialValue: _price.toString(),
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
    _timestampController.text = DateFormat.yMMMd().format(_timestamp!); // Initialize the text controller with the formatted timestamp value
    return TextFormField(
      controller: _timestampController, // Add the text controller to the text field
      decoration: InputDecoration(labelText: 'Timestamp'),
      readOnly: true, // Make the field read-only
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _timestamp ?? DateTime.now(),
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
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      child: Text('Save Changes'),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          try {
            final url = Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db/${widget.item['id']}');
            final response = await http.put(
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

            if (response.statusCode == 200) {
              Navigator.pop(context); // Go back to LogisticPage
            } else {
              print('Failed to update item: ${response.statusCode}');
            }
          } catch (e) {
            print('Error updating item: $e');
          }
        }
      },
    );
  }

  Widget _buildDeleteButton() {
    return ElevatedButton(
      child: Text('Delete Item'),
      onPressed: () async {
        try {
          final url = Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db/${widget.item['id']}');
          final response = await http.delete(url);

          if (response.statusCode == 200) {
            Navigator.pop(context); // Go back to LogisticPage
          } else {
            print('Failed to delete item: ${response.statusCode}');
          }
        } catch (e) {
          print('Error deleting item: $e');
        }
      },
    );
  }
}