import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'AddItemPage.dart';
import 'CartPage.dart';
import 'AdminEditItemPage.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final url = Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        _items = jsonData.cast<Map<String, dynamic>>();      });
    } else {
      print('Failed to load items: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Add Item'),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddItemPage()),
                );
                _loadItems(); // Reload items after adding a new item
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> item = _items[index];
                  return Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: item.keys.map((key) {
                              return Text('$key: ${item[key]}');
                            }).toList(),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Icon(Icons.edit),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AdminEditItemPage(item: item)),
                                );
                                _loadItems(); // Reload items after editing an item
                              },
                            ),
                            ElevatedButton(
                              child: Icon(Icons.shopping_cart),
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => 
                                    CartPage(item: item, 
                                      onUpdate: (updatedItem) { // Add this line
                                        setState(() {});
                                      }
                                    )
                                  ),
                                );
                                _loadItems(); // Reload items after editing an item
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}