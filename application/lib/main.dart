import 'package:flutter/material.dart';
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
  List<Produit> _items = [];
  String? selectedItem;
  List<Map<String, dynamic>> products = [];

  @override
  void initState() {
    super.initState();
    fetchProduct(); // Call the API when the widget is initialized
  }

  Future<void> fetchProduct() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.7/api/produits'));

      if (response.statusCode == 200) {
        final List<dynamic> products = json.decode(response.body);
        List<Produit> items = products.map((item) {
          return Produit(item['id'], item['name']);
        }).toList();
        setState(() {
          _items = items;
        });
      } else {
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
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
    String? selectedItemG = 'Ariana';

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
                  value: selectedItemG,
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
                  value: selectedItem,
                  onChanged: (item) {
                    setState(() {
                      selectedItem = item;
                    });
                  },
                  items:
                      _items.map<DropdownMenuItem<String>>((Produit produit) {
                    return DropdownMenuItem<String>(
                      value: produit.id.toString(),
                      child: Text(
                        produit.name,
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
