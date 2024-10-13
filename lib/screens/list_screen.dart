import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista'),
      ),
      body: Center(
        child: Text('Aquí va la lista', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}