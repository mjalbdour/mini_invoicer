import 'package:flutter/material.dart';

class HomeTileWidget extends StatelessWidget {
  final String name;
  final String onTap;

  const HomeTileWidget({
    Key key,
    @required this.name,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this.name),
        onTap: () => onTap(context),
      ),
    );
  }
}
