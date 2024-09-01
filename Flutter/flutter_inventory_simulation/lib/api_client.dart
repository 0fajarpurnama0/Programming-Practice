  import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static const String _baseUrl = 'http://localhost:3000';

  Future<http.Response> addItem(String item, String category, String description, String price) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/items'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': item,
        'category': category,
        'description': description,
        'price': price,
      }),
    );
    return response;
  }

  Future<http.Response> getItems() async {
    final response = await http.get(Uri.parse('$_baseUrl/items'));
    return response;
  }

  Future<http.Response> updateItem(int id, String item, String category, String description, String price) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/items/$id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': item,
        'category': category,
        'description': description,
        'price': price,
      }),
    );
    return response;
  }

  Future<http.Response> deleteItem(int id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/items/$id'));
    return response;
  }
}