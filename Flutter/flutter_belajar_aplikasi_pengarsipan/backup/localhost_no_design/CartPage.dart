import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onUpdate; // Add this line

  CartPage({required this.item, required this.onUpdate}); // Add this line

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _exitPriceController = TextEditingController();
  DateTime? _selectedExitAt;

  @override
  void initState() {
    super.initState();
    _reasonController.text = widget.item['reason'] ?? '';
    _exitPriceController.text = widget.item['exit_price']?.toString() ?? '';
    _selectedExitAt = widget.item['exit_at'] != null
        ? DateTime.parse(widget.item['exit_at'])
        : null;
  }

  Future<void> _updateItem() async {
    final url = Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db');
    final exitAt = _selectedExitAt != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(_selectedExitAt!) : null;
    final exitPrice = _exitPriceController.text.isNotEmpty ? _exitPriceController.text : null;
    final reason = _reasonController.text.isNotEmpty ? _reasonController.text : null;

    final response = await http.patch(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': widget.item['id'].toString(),
        'exit_at': exitAt,
        'reason': reason,
        'exit_price': exitPrice,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully updated
      Navigator.pop(context, {
        'id': widget.item['id'].toString(),
        'exit_at': exitAt,
        'reason': reason,
        'exit_price': exitPrice,
      });
      widget.onUpdate({ // Add this line
        'id': widget.item['id'].toString(),
        'exit_at': exitAt,
        'reason': reason,
        'exit_price': exitPrice,
      });
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Item: ${widget.item['name']}'),
            Text('Exit At: ${widget.item['exit_at'] ?? 'Not set'}'),
            Text('Reason: ${widget.item['reason'] ?? 'Not set'}'),
            Text('Exit Price: ${widget.item['exit_price'] ?? 'Not set'}'),
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            TextField(
              controller: _exitPriceController,
              decoration: InputDecoration(labelText: 'Exit Price'),
              keyboardType: TextInputType.number,
            ),
            ListTile(
              title: Text('Exit At: ${_selectedExitAt != null ? DateFormat('yyyy-MM-dd').format(_selectedExitAt!) : 'Not set'}'),
              trailing: Icon(Icons.calendar_today),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedExitAt ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _selectedExitAt = pickedDate;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}