import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_inventory/AddItemPage.dart';
import 'package:flutter_inventory/EditItemPage.dart';
import 'package:flutter_inventory/ExitItemPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [];
  String? _selectedCategory;
  String? _selectedExitReason;
  List<String> _categories = [];
  List<String> _exitReasons = [];
  bool _sortAscending = true;
  bool _sortExitPriceAscending = true;
  bool _sortDateAscending = true;
  bool _sortExitDateAscending = true;
  String? _selectedSortOption;
  String? _selectedExportOption;

  void _addItem(
      String item, String category, String description, String price) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    setState(() {
      _items.add({
        'name': item,
        'category': category,
        'description': description,
        'price': price,
        'reason': null,
        'timestamp': timestamp,
        'exitAt': null,
      });
      if (!_categories.contains(category)) {
        _categories.add(category);
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _deleteItemFromList(int index) {
    _deleteItem(index); // Existing method for deleting item
  }

  void _editItem(int index, String item, String category, String description,
      String price) {
    setState(() {
      _items[index]['name'] = item;
      _items[index]['category'] = category;
      _items[index]['description'] = description;
      _items[index]['price'] = price;
    });
  }

  Future<void> _exportToJson() async {
    final jsonData = _items
        .map((item) => {
              'name': item['name'],
              'category': item['category'],
              'description': item['description'],
              'price': item['price'],
            })
        .toList();

    final jsonString = jsonEncode(jsonData);

    print(jsonString);
  }

  Future<void> _exportToCsv() async {
    final csvData = _items
        .map((item) => [
              item['name'],
              item['category'],
              item['description'],
              item['price'].toString(),
            ])
        .map((row) => row.join(','))
        .join('\n');
    print(csvData);
  }

  Future<void> _exportToXml() async {
    final StringBuffer xmlData = StringBuffer();

    xmlData.write('<items>');
    for (var item in _items) {
      xmlData.write('<item>');
      xmlData.write('<name>${item['name']}</name>');
      xmlData.write('<category>${item['category']}</category>');
      xmlData.write('<description>${item['description']}</description>');
      xmlData.write('<price>${item['price']}</price>');
      xmlData.write('</item>');
    }
    xmlData.write('</items>');
    print(xmlData.toString());
  }

  void _sortItemsByPrice() {
    setState(() {
      _sortAscending = !_sortAscending;

      _items.sort((a, b) => _sortAscending
          ? double.parse(a['price']).compareTo(double.parse(b['price']))
          : double.parse(b['price']).compareTo(double.parse(a['price'])));
    });
  }

  void _sortItemsByExitPrice() {
    setState(() {
      _sortExitPriceAscending = !_sortExitPriceAscending;

      _items.sort((a, b) => a['exitPrice'] != null && b['exitPrice'] != null
          ? _sortExitPriceAscending
              ? double.parse(a['exitPrice'])
                  .compareTo(double.parse(b['exitPrice']))
              : double.parse(b['exitPrice'])
                  .compareTo(double.parse(a['exitPrice']))
          : 0);
    });
  }

  void _sortItemsByDate() {
    setState(() {
      _sortDateAscending = !_sortDateAscending;

      _items.sort((a, b) => _sortDateAscending
          ? a['timestamp'].compareTo(b['timestamp'])
          : b['timestamp'].compareTo(a['timestamp']));
    });
  }

  void _sortItemsByExitDate() {
    setState(() {
      _sortExitDateAscending = !_sortExitDateAscending;

      _items.sort((a, b) {
        if (a['exitAt'] == null && b['exitAt'] == null) {
          return 0; // both are null, so they are equal
        } else if (a['exitAt'] == null) {
          return _sortExitDateAscending
              ? 1
              : -1; // a is null, so it comes after/before b
        } else if (b['exitAt'] == null) {
          return _sortExitDateAscending
              ? -1
              : 1; // b is null, so it comes after/before a
        } else {
          return _sortExitDateAscending
              ? a['exitAt'].compareTo(b['exitAt'])
              : b['exitAt'].compareTo(a['exitAt']);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _selectedCategory == null
        ? _selectedExitReason == null
            ? _items
            : _items
                .where((item) => item['reason'] == _selectedExitReason)
                .toList()
        : _items
            .where((item) =>
                item['category'] == _selectedCategory &&
                (_selectedExitReason == null ||
                    item['reason'] == _selectedExitReason))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddItemPage(_addItem)),
                );
              },
              icon: Icon(Icons.add),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: Text('Filter by Category'),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Show all'),
                ),
                ..._categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            DropdownButton<String>(
              value: _selectedExitReason,
              hint: Text('Filter by Exit Reason'),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Show all'),
                ),
                ..._exitReasons.map((String reason) {
                  return DropdownMenuItem<String>(
                    value: reason,
                    child: Text(reason),
                  );
                }),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedExitReason = newValue;
                });
              },
            ),
            DropdownButton<String>(
              value: _selectedSortOption,
              hint: Text('Sort by'),
              items: [
                DropdownMenuItem<String>(
                  value: 'price',
                  child: Text('Price'),
                ),
                DropdownMenuItem<String>(
                  value: 'exitPrice',
                  child: Text('Exit Price'),
                ),
                DropdownMenuItem<String>(
                  value: 'date',
                  child: Text('Added Date'),
                ),
                DropdownMenuItem<String>(
                  value: 'exitDate',
                  child: Text('Exit Date'),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedSortOption = newValue;

                  if (newValue == 'price') {
                    _sortItemsByPrice();
                  } else if (newValue == 'exitPrice') {
                    _sortItemsByExitPrice();
                  } else if (newValue == 'date') {
                    _sortItemsByDate();
                  } else if (newValue == 'exitDate') {
                    _sortItemsByExitDate();
                  }
                });
              },
            ),
            DropdownButton<String>(
              value: _selectedExportOption,
              hint: Text('Export to'),
              items: [
                DropdownMenuItem<String>(
                  value: 'json',
                  child: Text('JSON'),
                ),
                DropdownMenuItem<String>(
                  value: 'csv',
                  child: Text('CSV'),
                ),
                DropdownMenuItem<String>(
                  value: 'xml',
                  child: Text('XML'),
                ),
              ],
              onChanged: (newValue) {
                setState(() {
                  _selectedExportOption = newValue;

                  if (newValue == 'json') {
                    _exportToJson();
                  } else if (newValue == 'csv') {
                    _exportToCsv();
                  } else if (newValue == 'xml') {
                    _exportToXml();
                  }
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final timestamp = DateTime.fromMillisecondsSinceEpoch(
                      filteredItems[index]['timestamp']);
                  final exitAt = filteredItems[index]['exitAt'] != null
                      ? DateTime.fromMillisecondsSinceEpoch(
                          filteredItems[index]['exitAt'])
                      : null;
                  return ListTile(
                    title: Text(filteredItems[index]['reason'] != null
                        ? '${filteredItems[index]['name']} - ${filteredItems[index]['reason']} (Exit Price: ${filteredItems[index]['exitPrice']})'
                        : filteredItems[index]['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filteredItems[index]['category']),
                        Text(filteredItems[index]['description']),
                        Text(filteredItems[index]['price']),
                        Text(
                            'Added at: ${timestamp.hour}:${timestamp.minute}:${timestamp.second}'),
                        exitAt != null
                            ? Text(
                                'Exit at: ${exitAt.hour}:${exitAt.minute}:${exitAt.second}')
                            : Container(),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditItemPage(
                                  filteredItems[index],
                                  (String name, String category,
                                          String description, String price) =>
                                      _editItem(index, name, category,
                                          description, price),
                                  () => _deleteItemFromList(
                                      index), // Pass delete method
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ExitFormPage(),
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                final exitAt =
                                    DateTime.now().millisecondsSinceEpoch;
                                _items[index]['exitAt'] = exitAt;
                                _items[index]['reason'] = result['reason'];
                                _items[index]['exitPrice'] = result['price'];
                                if (!_exitReasons.contains(result['reason'])) {
                                  _exitReasons.add(result['reason']);
                                }
                              });
                            }
                          },
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