import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'LoginPage.dart';
import 'EditUserPage.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPage createState() => _UsersPage();
}

class _UsersPage extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: Center(
        child: _buildusersList(),
      ),
    );
  }

  Widget _buildusersList() {
    return FutureBuilder(
      future: usersAPI(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic> jsonData = snapshot.data != null ? jsonDecode(snapshot.data!) : [];
          return ListView.builder(
            itemCount: jsonData.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> user = jsonData[index];
              List<Widget> children = <Widget>[];

              for (var key in user.keys) {
                children.add(
                  Text('$key: ${user[key]}'),
                );
              }

              children.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditUserPage(
                              user: user,
                              onSaved: () async {
                                // Refetch the data from the users table
                                setState(() {});
                                await usersAPI(); // Refetch the data
                              },
                            ),
                          ),
                        );
                      },
                      child: Text('Edit'),
                    ),
                  ],
                ),
              );

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                ),
              );
            },
          );
        } else {
          return Text('Loading...');
        }
      },
    );
  }
}

void logout(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
}

Future<String> usersAPI() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000/flutter_latihan_arsip_barang_users_db'));
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