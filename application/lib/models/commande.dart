class Commande {
  int id;
  String produit;
  String reference;
  String nom;
  String prenom;
  String region;
  String adresse;
  int quantite;

  Commande(
      {required this.id,
      required this.produit,
      required this.reference,
      required this.quantite,
      required this.nom,
      required this.prenom,
      required this.region,
      required this.adresse});

  factory Commande.fromJson(json) => Commande(
      id: json['id'],
      produit: json['type'],
      reference: json['name'],
      quantite: json['qte'],
      nom: json['nom'],
      prenom: json['prenom'],
      region: json['region'],
      adresse: json['adresse']);
}
