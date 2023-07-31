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
          await http.get(Uri.parse('http://192.168.1.240/api/mescommandes'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = data
              .map((item) => Commande(item['type'], item['name'], item['qte']))
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Order()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  primary: Colors.blue,
                ),
                child: Text(
                  "Commander",
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              DataTable(
                columns: [
                  DataColumn(label: Text('Produit')),
                  DataColumn(label: Text('Référence')),
                  DataColumn(label: Text('Quantité')),
                ],
                rows: items.map((item) {
                  return DataRow(
                    cells: [
                      DataCell(Text(item.produit.toString())),
                      DataCell(Text(item.reference.toString())),
                      DataCell(Text(item.quantite.toString())),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
