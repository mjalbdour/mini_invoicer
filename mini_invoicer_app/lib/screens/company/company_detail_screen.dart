import 'package:flutter/material.dart';

class CompanyDetailScreen extends StatefulWidget {
  @override
  _CompanyDetailScreenState createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("company name here"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[Text("details here...")],
      ),
    );
  }
}
