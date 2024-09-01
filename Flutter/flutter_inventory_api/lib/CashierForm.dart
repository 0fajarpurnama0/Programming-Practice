import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CashierForm extends StatefulWidget {
  final dynamic item;

  CashierForm(this.item);

  @override
  _CashierFormState createState() => _CashierFormState();
}

class _CashierFormState extends State<CashierForm> {
  final _exitPriceController = TextEditingController();
  final _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cashier Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Item: ${widget.item['name']}'),
            Text('Category: ${widget.item['category']}'),
            TextFormField(
              controller: _exitPriceController,
              decoration: InputDecoration(labelText: 'Exit Price'),
            ),
            TextFormField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _cashoutItem,
              child: Text('Cash Out'),
            ),
          ],
        ),
      ),
    );
  }

  void _cashoutItem() async {
    final exitPrice = double.tryParse(_exitPriceController.text) ?? 0.0;
    final reason = _reasonController.text;
    final exitAt = DateTime.now().toIso8601String();

    final url =
        Uri.parse('http://localhost:3000/items/${widget.item['id']}/cashout');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'exitPrice': exitPrice,
        'reason': reason,
        'exitAt': exitAt,
      }),
    );

    if (response.statusCode == 200) {
      print('Item cashed out successfully');
      Navigator.of(context).pop();
    } else {
      print('Failed to cash out item');
    }
  }
}