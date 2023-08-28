import 'package:application/commande.dart';
import 'package:application/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommandesList extends StatefulWidget {
  @override
  _CommandesListState createState() => _CommandesListState();
}

class _CommandesListState extends State<CommandesList> {
  List<Commande> items = [];

  Future<void> fetchOrders() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.8/api/mescommandes'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = data
              .map((item) => Commande(item['type'], item['name'], item['qte'],
                  item['nom'], item['prenom'], item['region'], item['adresse']))
              .toList();
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){},
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.logout),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(children: [
        SizedBox(height: 50,),
      Text("Liste des commandes ", style: TextStyle(fontSize: 25)) ,
        SizedBox(height: 20,),
        Container(
        height: 700,
        padding: const EdgeInsets.only(
            left: 20, right: 20), // Add padding around the body
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4, // Add some elevation to the card
              margin: const EdgeInsets.symmetric(vertical: 2),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15), // Add content padding
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${items[index].nom} ${items[index].prenom}',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${items[index].region}, ${items[index].adresse}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ],
                ),
                subtitle: Text(
                  'Référence: ${items[index].reference}',
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
                      items[index].quantite.toString(),
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),],)
    );
  }
}
