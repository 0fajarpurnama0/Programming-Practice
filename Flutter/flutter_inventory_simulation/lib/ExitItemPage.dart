import 'package:flutter/material.dart';

class ExitFormPage extends StatelessWidget {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exit Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _reasonController,
              decoration: InputDecoration(labelText: 'Reason'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Exit Price'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'reason': _reasonController.text,
                  'price': _priceController.text,
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}