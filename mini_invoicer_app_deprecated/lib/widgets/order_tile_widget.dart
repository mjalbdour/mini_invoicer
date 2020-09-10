import 'package:flutter/material.dart';
import 'package:mini_invoicer_app/models/customer_model.dart';
import 'package:mini_invoicer_app/models/order_model.dart';
import 'package:mini_invoicer_app/screens/order/order_detail_screen.dart';

class OrderTileWidget extends StatelessWidget {
  final Order order;
  final Customer customer;
  OrderTileWidget({@required this.order, @required this.customer});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(order.date.toString()),
        subtitle: Text(order.totalValue.toString()),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderDetailScreen(
                    order: order,
                    customer: customer,
                  )));
        },
      ),
    );
  }
}
