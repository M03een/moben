import 'package:flutter/material.dart';



class MyHomePage extends StatelessWidget {
  // Sample data for the list
  final List<String> items = List<String>.generate(20, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple ListView'),
      ),
      body: Scrollbar(
        thickness: 10,
        thumbVisibility: true,
        radius: const Radius.circular(15),

        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.list),
              title: Text(items[index]),
              trailing: const Icon(Icons.arrow_forward),
            );
          },
        ),
      ),
    );
  }
}
