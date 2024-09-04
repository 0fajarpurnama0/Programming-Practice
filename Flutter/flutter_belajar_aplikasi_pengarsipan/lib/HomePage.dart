import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomePageExport.dart';
import 'LoginPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? _selectedCategory;
  String? _selectedReason;
  String? _selectedSort;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: buildItemsList(),
      ),
    );
  }

  Widget buildItemsList() {
    return FutureBuilder(
      future: ItemsAPI(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> jsonData = snapshot.data != null ? jsonDecode(snapshot.data!) : [];

          // Get unique categories from the items
          List<dynamic> categories = jsonData.map((item) => item['category']).toSet().toList();
          categories.insert(0, 'All categories'); // Add "All categories" option

          // Get unique reasons from the items
          List<dynamic> reasons = jsonData.map((item) => item['reason']).toSet().toList();
          reasons.insert(0, 'All reason');

          // Get unique sort options
          List<String> sortOptions = ['Lowest price', 'Highest price', 'Lowest exit price', 'Highest exit price'];

          List<dynamic> filteredItems;
          if (_selectedCategory != null && _selectedReason != null) {
            if (_selectedReason == 'All reason') {
              filteredItems = jsonData.where((item) => item['category'] == _selectedCategory).toList();
            } else {
              filteredItems = jsonData
                  .where((item) => item['category'] == _selectedCategory)
                  .where((item) => item['reason'] == _selectedReason)
                  .toList();
            }
          } else if (_selectedCategory != null) {
            if (_selectedCategory == 'All categories') {
              filteredItems = jsonData;
            } else {
              filteredItems = jsonData.where((item) => item['category'] == _selectedCategory).toList();
            }
          } else if (_selectedReason != null) {
            if (_selectedReason == 'All reason') {
              filteredItems = jsonData; // Display all items when "All reason" is selected
            } else {
              filteredItems = jsonData.where((item) => item['reason'] == _selectedReason).toList();
            }
          } else {
            filteredItems = jsonData;
          }

          // Apply sort
          if (_selectedSort == 'Lowest price') {
            filteredItems.sort((a, b) => a['price'].compareTo(b['price']));
          } else if (_selectedSort == 'Highest price') {
            filteredItems.sort((a, b) => b['price'].compareTo(a['price']));
          } else if (_selectedSort == 'Lowest exit price') {
            filteredItems.sort((a, b) {
              if (a['exit_price'] == null) return -1; // or some other default value
              if (b['exit_price'] == null) return 1; // or some other default value
              return a['exit_price'].compareTo(b['exit_price']);
            });
          } else if (_selectedSort == 'Highest exit price') {
            filteredItems.sort((a, b) {
              if (a['exit_price'] == null) return 1; // or some other default value
              if (b['exit_price'] == null) return -1; // or some other default value
              return b['exit_price'].compareTo(a['exit_price']);
            });
          }

          return Column(
            children: [
              DropdownButtonFormField(
                value: _selectedCategory,
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value as String?;
                  });
                },
                items: categories.map((category) => DropdownMenuItem(
                  value: category,
                  child: Text(category),
                )).toList(),
                decoration: InputDecoration(
                  labelText: 'Filter by Category',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedReason,
                onChanged: (value) {
                  setState(() {
                    _selectedReason = value as String?;
                  });
                },
                items: reasons.map((reason) => DropdownMenuItem(
                  value: reason,
                  child: Text(reason ?? 'No reason'),
                )).toList(),
                decoration: InputDecoration(
                  labelText: 'Filter by Reason',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedSort,
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value as String?;
                  });
                },
                items: sortOptions.map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                )).toList(),
                decoration: InputDecoration(
                  labelText: 'Sort by',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField(
                value: null,
                onChanged: (value) async {
                  if (value == 'Export to JSON') {
                    _exportData(context, 'JSON', filteredItems);
                  } else if (value == 'Export to XML') {
                    _exportData(context, 'XML', filteredItems);
                  } else if (value == 'Export to CSV') {
                    _exportData(context, 'CSV', filteredItems);
                  }
                },
                items: ['Export to JSON', 'Export to XML', 'Export to CSV'].map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                )).toList(),
                decoration: InputDecoration(
                  labelText: 'Export',
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredItems.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> item = filteredItems[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: item.keys.map((key) {
                            return Text('$key: ${item[key]}');
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

void logout(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

Future<String> ItemsAPI() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_items_db'));
    if (response.statusCode == 200) {
      final jsonString = response.body;
      return jsonString;
    } else {
      return 'failed: ${response.statusCode}';
    }
  } catch (e) {
    return 'Error: $e';
  }
}

// Export logic function (outside of the class)
void _exportData(BuildContext context, String exportType, List<dynamic> filteredItems) {
  String _exportedData = '';
  String _exportType = exportType;

  if (exportType == 'JSON') {
    _exportedData = jsonEncode(filteredItems);
  } else if (exportType == 'XML') {
    _exportedData += '<items>';
    filteredItems.forEach((item) {
      _exportedData += '<item>';
      item.forEach((key, value) {
        _exportedData += '<$key>$value</$key>';
      });
      _exportedData += '</item>';
    });
    _exportedData += '</items>';
  } else if (exportType == 'CSV') {
    _exportedData += '${filteredItems.map((item) => item.keys.join(',')).join('\n')}\n';
    filteredItems.forEach((item) {
      _exportedData += '${item.values.join(',')}\n';
    });
  }

  // Redirect to HomePageExport
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePageExport(_exportedData, _exportType)),
  );
}