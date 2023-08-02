import 'package:application/home_page.dart';
import 'package:application/login.dart';
import 'package:application/services/auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:application/produit.dart';
import 'package:application/commandes_list.dart';
import 'package:application/form.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Auth())],
      child: GPC()));
}

class GPC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final formKey = GlobalKey<FormState>();
  List<Produit> _items =
      []; //list of filtred products returned by fetchProduct()

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
  ]; //list of gouvernorats
  List<String> produits = [
    'Panneau',
    'Onduleur',
    'Variateur'
  ]; // list of product types
  String? selectedItem; // variable take id of selected product reference
  String? selectedProduct; // variable take id of selected product type
  String? selectedItemG; //variable take id of selected Governorat
  bool? isVisible = false; // controls address text input visibility
  String? nameValue; // value of firstname textfield
  String? lastNameValue; // value of lastname textfield
  String? addresValue; // value of address textfield
  String? quantityValue; // value of quantity textfield
  List<FormData> formDataList = [];
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<void> commandeDetail(
      String? qte, String? produitID, String? commandeID) async {
    try {
      Map<String, dynamic> request = {
        'id_demande': commandeID,
        'produit': produitID,
        'qte': qte,
      };
      final uri = Uri.parse("http://192.168.1.240/api/c_details/create");
      final response = await http.post(uri, body: request);
      if (response.statusCode == 200) {
        print('Details Commande created successfully!');
      } else {
        print(
            'Failed to create details commande. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request aaaa: $e');
    }
  }

  Future<void> createCommande(
      String nom, String prenom, String region, String adresse) async {
    try {
      Map<String, dynamic> request = {
        'user_id': "1",
        'nom': nom,
        'prenom': prenom,
        'region': region,
        'adresse': adresse,
        'puissance': '55',
        'etat': 'Réservée'
      };
      final uri = Uri.parse("http://192.168.1.240/api/commandes/create");
      final response = await http.post(uri, body: request);

      if (response.statusCode == 200) {
        print(response.body);
        Map<String, dynamic> responseData = json.decode(response.body);
        int idCommande = responseData["id"];
        commandeDetail(quantityValue, selectedItem, idCommande.toString());
      } else {
        // Request failed with a non-200 status code
        print('Failed to create commande. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during the API call
      print('Error during API request: $e');
    }
  }

  Future<void> fetchProduct(String type) async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.1.4/api/produits/type/$type'));
      if (response.statusCode == 200) {
        final List<dynamic> products = json.decode(response.body);
        List<Produit> items = products.map((item) {
          return Produit(item['id'], item['name']);
        }).toList();
        setState(() {
          _items = items;
          selectedItem = null;
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

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 242, 233, 233),
      body: Stepper(
        type: StepperType.horizontal,
        steps: getSteps(),
        currentStep: currentStep,
        onStepTapped: (step) => setState(() => currentStep = step),
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;
          if (isLastStep) {
            print("Complete");
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () {
          currentStep == 0 ? null : setState(() => currentStep -= 1);
        },
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            title: const Text('Adresse'),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Nom"),
                  onChanged: (value) {
                    setState(() {
                      nameValue = value;
                    });
                  },
                ),
                TextFormField(
                    decoration: const InputDecoration(labelText: "Prénom"),
                    onChanged: (value) {
                      setState(() {
                        lastNameValue = value;
                      });
                    }),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Gouvernorat"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: const Text(
                    "Sélectionnez votre gouvernorat",
                    style: TextStyle(fontSize: 22),
                  ),
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
                TextFormField(
                    enabled: isVisible,
                    decoration: const InputDecoration(labelText: "Adresse"),
                    onChanged: (value) {
                      setState(() {
                        addresValue = value;
                      });
                    }),
              ],
            )),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: const Text('Produits'),
            content: Column(
              children: [
                SizedBox(
                  height: 400, // Set an appropriate height for the ListView
                  child: ListView.builder(
                    itemCount: formDataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == formDataList.length) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                child: const Text(
                                  "Commander",
                                  style: TextStyle(fontSize: 22),
                                ),
                                onPressed: () {
                                  createCommande(
                                      nameValue.toString(),
                                      lastNameValue.toString(),
                                      selectedItemG.toString(),
                                      addresValue.toString());
                                }),
                            ElevatedButton(
                              child: const Text(
                                "+",
                                style: TextStyle(fontSize: 22),
                              ),
                              onPressed: () {
                                setState(() {
                                  formDataList.add(FormData());
                                });
                              },
                            )
                          ],
                        );
                      } else {
                        FormData formData = formDataList[index];
                        return buildForm(formData);
                      }
                    },
                  ),
                ),
              ],
            )),
        Step(
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 2,
            title: const Text('Complete'),
            content: Container())
      ];

  Widget buildForm(FormData form) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: "Produit"),
          icon: const Icon(Icons.keyboard_arrow_down),
          hint: const Text(
            'Produit',
            style: TextStyle(fontSize: 22),
          ),
          value: selectedProduct,
          onChanged: (item) => setState(() {
            selectedProduct = item;
            fetchProduct(selectedProduct.toString());
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
        DropdownButtonFormField<String>(
          hint: const Text(
            "Veuillez choisir un référence",
            style: TextStyle(fontSize: 22),
          ),
          decoration: const InputDecoration(labelText: "Référence"),
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
        TextFormField(
            decoration: const InputDecoration(labelText: "Quantité"),
            onChanged: (value) {
              setState(() {
                quantityValue = value;
              });
            }),

        const Divider(), // To separate each form visually (optional)
      ],
    );
  }
}
