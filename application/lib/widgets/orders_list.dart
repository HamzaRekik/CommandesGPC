import 'package:application/models/commande.dart';
import 'package:application/widgets/order_widget.dart';
import 'package:flutter/material.dart';

class OrdersList extends StatelessWidget {
  OrdersList({required this.commandes});
  final List<Commande> commandes;
  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: commandes.length,
            (context, index) {
      return OrderWidget(
        commande: commandes[index],
      );
    }));
  }
}
