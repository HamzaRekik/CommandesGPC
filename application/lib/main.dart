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

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMainScreen(); // Démarre la temporisation et la transition
  }

  Future<void> _navigateToMainScreen() async {
    await Future.delayed(Duration(seconds: 6)); // Temporisation de 3 secondes

    // Navigue vers l'écran principal ou la page suivante
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond de l'écran de démarrage
      body: Center(
        child: Image.asset('images/gpc.png')
      ),
    );
  }
}


class GPC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
      final uri = Uri.parse("http://192.168.100.188/api/c_details/create");
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
      final uri = Uri.parse("http://192.168.100.188/api/commandes/create");
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
          .get(Uri.parse('http://192.168.100.188/api/produits/type/$type'));
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
        floatingActionButton: FloatingActionButton(backgroundColor: Colors.blueAccent,
          onPressed: (){ Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );},
        child: Icon(Icons.arrow_back),),floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 80),
            color: const Color.fromRGBO(229, 229, 235, 255),
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Container(alignment: Alignment.bottomLeft,
                  child:Text("Bienvenue ! ", style: TextStyle(fontSize: 35)) ,),
                SizedBox(height: 30,),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Nom",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  onChanged: (values) {
                    setState(() {
                      nameValue = values;
                    });
                  },
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Prénom",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        lastNameValue = value;
                      });
                    }),
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
                    enabled: isVisible,
                    decoration: const InputDecoration(
                      labelText: "Adresse",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        addresValue = value;
                      });
                    }),
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
                  items:
                      _items.map<DropdownMenuItem<String>>((Produit produit) {
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
                    decoration: const InputDecoration(
                      labelText: "Quantité",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        quantityValue = value;
                      });
                    }),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    createCommande(
                        nameValue.toString(),
                        lastNameValue.toString(),
                        selectedItemG.toString(),
                        addresValue.toString());
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
        ));
  }
}
