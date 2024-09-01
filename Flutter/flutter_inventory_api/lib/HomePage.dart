import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inventory_api/CashierForm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inventory_api/AddItemPage.dart';
import 'package:flutter_inventory_api/EditItemScreen.dart';


class HomePage extends StatefulWidget {
  late String user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  late String user;

  _HomePageState(this.user);

  Future<List<dynamic>> _fetchItems() async {
    final apiUrl = 'http://localhost:3000/items'; // Replace with your API URL
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load items');
    }
  }

  void _refreshItems() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _refreshItems,
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _fetchItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index];

                  return Card(
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['name']),
                          Text(item['category']),
                          Text(item['description']),
                          Text('Price: ${item['price']}'),
                          Text('Timestamp: ${item['timestamp']}'),
                          Text(
                              'Exit Timestamp: ${item['exit_at'] ?? 'Not provided'}'),
                          Text('Reason: ${item['reason'] ?? 'Not provided'}'),
                          Text(
                              'Exit Price: ${item['exit_price']?.toString() ?? 'Not provided'}'),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CashierForm(item),
                                    ),
                                  );
                                },
                                child: Text('Cashier'),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          EditItemScreen(itemId: item['id'])));
                                },
                                child: Text('Edit'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddItemPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}