import 'package:flutter/material.dart';

class HomePageExport extends StatelessWidget {
  final String exportedData;
  final String exportType;

  HomePageExport(this.exportedData, this.exportType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exported $exportType'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(exportedData),
      ),
    );
  }
}