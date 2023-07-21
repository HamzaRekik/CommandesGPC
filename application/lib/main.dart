import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/produit.dart';

void main() {
  runApp(GPC());
}

class GPC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Order(),
    );
  }
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formKey = GlobalKey<FormState>();
  int _value = 1;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProduct(); // Call the API when the widget is initialized
  }

  fetchProduct() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/produits'));

    if (response.statusCode == 200) {
      products = List<Map<String, dynamic>>.from(json.decode(response.body));
      setState(() {});
    } else {
      throw Exception("Failed To Load Product");
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    List<String> gouvernorats = [
      'Ariana',
      "Béja",
      "Ben Arous",
      "Bizerte",
      "Gabès",
      "Gafsa",
      "Jendouba",
      "Kairouan",
      "Kasserine",
      "Kébili",
      "Le Kef",
      "Mahdia",
      "Manouba",
      "Medenine",
      "Monastir",
      "Nabeul",
      "Sfax",
      "Sidi Bouzid",
      "Siliana",
      "Sousse",
      "Tataouine",
      "Tozeur",
      "Tunis",
      "Zaghouan"
    ]; // Your list of gouvernorats
    List<String> produits = ['Panneau', 'Onduleur', 'Variateur'];

    String? selectedProduct = 'Panneau';
    String? selectedItem = 'Ariana';

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Bienvenue !",
                  style: TextStyle(
                      fontSize: 30, color: Color.fromARGB(255, 4, 7, 31)),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Nom"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Prénom"),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Gouvernorat"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: Text('Gouvernorat'),
                  value: selectedItem,
                  onChanged: (item) => setState(() => selectedItem = item),
                  items: gouvernorats.map((String gouvernorat) {
                    return DropdownMenuItem<String>(
                      value: gouvernorat,
                      child: Text(
                        gouvernorat,
                        style: TextStyle(fontSize: 22),
                      ),
                    );
                  }).toList(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Adresse"),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: "Produit"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: Text('Produit'),
                  value: selectedProduct,
                  onChanged: (item) => setState(() => selectedProduct = item),
                  items: produits.map((String produit) {
                    return DropdownMenuItem<String>(
                      value: produit,
                      child: Text(
                        produit,
                        style: TextStyle(fontSize: 22),
                      ),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  value: _value.toString(),
                  onChanged: (item) {
                    setState(() {
                      _value = int.parse(item!);
                    });
                  },
                  items: products.map((product) {
                    return DropdownMenuItem<String>(
                      value: product["id"].toString(),
                      child: Text(
                        product["name"].toString(),
                        style: TextStyle(fontSize: 22),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
