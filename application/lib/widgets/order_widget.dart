import 'package:application/models/commande.dart';
import 'package:application/services/ProductsService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({required this.commande});
  final Commande commande;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Add some elevation to the card
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
                            .deleteOrder(commande.id.toString());
                        ProductsService(Dio()).fetchOrders();
                        Navigator.pop(context);
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
        contentPadding: const EdgeInsets.all(15), // Add content padding
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${commande.id} |  ${commande.nom} ${commande.prenom}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              '${commande.region}, ${commande.adresse}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        subtitle: Text(
          'Référence: ${commande.reference}',
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
              '${commande.quantite}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
