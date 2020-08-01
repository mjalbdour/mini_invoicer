import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/screens/customer/customer_detail_screen.dart';

class CustomerTileWidget extends StatelessWidget {
  final Customer customer;
  CustomerTileWidget({@required this.customer});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(customer.name),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CustomerDetailScreen(customer: customer),
            ),
          );
        },
      ),
    );
  }
}
