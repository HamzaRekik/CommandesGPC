import 'package:application/models/commande.dart';
import 'package:dio/dio.dart';

class ProductsService {
  Dio dio;
  ProductsService(this.dio);

  Future<List<Commande>> fetchOrders() async {
    List<Commande> commandes = [];
    try {
      Response response = await dio.get("http://192.168.1.8/api/mescommandes");
      for (var commande in response.data) {
        Commande cmd = Commande.fromJson(commande);
        commandes.add(cmd);
      }
      return commandes;
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteOrder(String id) async {
    try {
      await dio.delete('http://192.168.1.8/api/commandes/delete/$id');
      fetchOrders();
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> makeOrder(String nom, String prenom, String region,
      String adresse, String qte, String reference) async {
    try {
      Map<String, dynamic> order = {
        'user_id': "1",
        'nom': nom,
        'prenom': prenom,
        'region': region,
        'adresse': adresse,
        'puissance': '55',
        'etat': 'Réservée'
      };
      Response response = await dio
          .post("http://192.168.1.8/api/commandes/create", data: order);
      int idCommande = response.data["id"];
      orderDetails(qte, reference, idCommande.toString());
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<void> orderDetails(
      String qte, String produitID, String commandeID) async {
    Map<String, dynamic> orderDetail = {
      'id_demande': commandeID,
      'produit': produitID,
      'qte': qte,
    };
    try {
      await dio.post("http://192.168.1.8/api/c_details/create",
          data: orderDetail);
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<List<String>> getProductReferences(String type) async {
    List<String> references = [];
    try {
      Response response =
          await dio.get('http://192.168.1.8/api/produits/type/$type');
      for (var reference in response.data) {
        references.add(reference['name']);
      }
      return references;
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }
}
