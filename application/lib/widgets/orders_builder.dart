import 'package:application/models/commande.dart';
import 'package:application/services/ProductsService.dart';
import 'package:application/widgets/orders_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrdersBuilder extends StatefulWidget {
  const OrdersBuilder({
    super.key,
  });

  @override
  State<OrdersBuilder> createState() => _OrdersBuilderState();
}

class _OrdersBuilderState extends State<OrdersBuilder> {
  var commandes;

  @override
  void initState() {
    commandes = ProductsService(Dio()).fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Commande>>(
        future: commandes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return OrdersList(commandes: snapshot.data!);
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: const Center(
                child: Text('an error occured'),
              ),
            );
          } else
            return SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        });
  }
}
