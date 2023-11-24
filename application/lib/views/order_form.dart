import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/produit.dart';
import '../services/ProductsService.dart';
import '../static/governorats.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formKey = GlobalKey<FormState>();
  String? selectedItem; // variable take id of selected product reference
  String? selectedProduct; // variable take id of selected product type
  String? selectedItemG; //variable take id of selected Governorat
  bool isVisible = false; // controls address text input visibility

  List<Produit> _items =
      []; //list of filtred products returned by fetchProduct()

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    addController.dispose();
    quanController.dispose();
    super.dispose();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController quanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: const EdgeInsets.only(top: 80),
          color: const Color.fromRGBO(229, 229, 235, 255),
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child:
                    const Text("Bienvenue ! ", style: TextStyle(fontSize: 35)),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nom",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  labelText: "Prénom",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Gouvernorat",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                value: selectedItemG,
                onChanged: (item) => setState(() {
                  selectedItemG = item;
                  isVisible = true;
                }),
                items: gouvernorats.map((String gouvernorat) {
                  return DropdownMenuItem<String>(
                    value: gouvernorat,
                    child: Text(
                      gouvernorat,
                      style: const TextStyle(fontSize: 22),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: addController,
                enabled: isVisible,
                decoration: const InputDecoration(
                  labelText: "Adresse",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Produit",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                value: selectedProduct,
                onChanged: (item) => setState(() {
                  ProductsService(Dio()).getProductReferences(item.toString());
                }),
                items: produits.map((String produit) {
                  return DropdownMenuItem<String>(
                    value: produit,
                    child: Text(
                      produit,
                      style: const TextStyle(fontSize: 22),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Référence",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
                icon: const Icon(Icons.keyboard_arrow_down),
                value: selectedItem,
                onChanged: (item) {
                  setState(() {
                    selectedItem = item;
                  });
                },
                items: _items.map<DropdownMenuItem<String>>((Produit produit) {
                  return DropdownMenuItem<String>(
                    value: produit.id.toString(),
                    child: Text(
                      produit.name,
                      style: const TextStyle(fontSize: 22),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: quanController,
                decoration: const InputDecoration(
                  labelText: "Quantité",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  ProductsService(Dio()).makeOrder(
                      nameController.text,
                      lastNameController.text,
                      selectedItemG.toString(),
                      addController.text,
                      quanController.text,
                      selectedItem.toString());

                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Okay"))
                          ],
                          title: Text("Cher Hamza Rekik"),
                          content: const Text(
                              "Votre commande a été passée avec succès!"),
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Commander',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
