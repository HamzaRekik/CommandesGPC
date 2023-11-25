import 'package:application/models/commande.dart';
import 'package:application/services/ProductsService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({required this.commande});
  final Commande commande;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        ProductsService(Dio())
                            .deleteOrder(widget.commande.id.toString());
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/orders_list');
                      },
                      child: Text("Supprimer")),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Annuler"))
                ],
                title: Text("Voulez vous supprimer cet Commande ?"),
              );
            },
          );
        },
        contentPadding: const EdgeInsets.all(15),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.commande.id} |  ${widget.commande.nom} ${widget.commande.prenom}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '${widget.commande.region}, ${widget.commande.adresse}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        subtitle: Text(
          'Référence: ${widget.commande.reference}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Quantité',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            Text(
              '${widget.commande.quantite}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
