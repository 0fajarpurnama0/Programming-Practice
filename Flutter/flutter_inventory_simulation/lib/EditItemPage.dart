import 'package:flutter/material.dart';

class EditItemPage extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(String, String, String, String) editItem;
  final VoidCallback deleteItem;

  EditItemPage(this.item, this.editItem, this.deleteItem);

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _itemController.text = item['name'];
    _categoryController.text = item['category'];
    _descriptionController.text = item['description'];
    _priceController.text = item['price'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _itemController,
              decoration: InputDecoration(labelText: 'Item'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteItem(); // Call delete method when button is pressed
                Navigator.pop(
                    context); // Optionally pop the page after deletion
              },
              child: Text('Delete'), // Delete button
            ),
            ElevatedButton(
              onPressed: () {
                editItem(
                  _itemController.text,
                  _categoryController.text,
                  _descriptionController.text,
                  _priceController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}