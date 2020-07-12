import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/screens/product/product_list_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Products"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductListScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
