import 'package:flutter/material.dart';

class HomeTileWidget extends StatelessWidget {
  final String name;
  final String route;

  const HomeTileWidget({
    Key key,
    @required this.name,
    @required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this.name),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
