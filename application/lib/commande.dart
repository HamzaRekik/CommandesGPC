class Commande {
  int? id;
  String? produit;
  String? reference;
  String? nom;
  String? prenom;
  String? region;
  String? adresse;
  int? quantite;

  Commande(this.id, this.produit, this.reference, this.quantite, this.nom,
      this.prenom, this.region, this.adresse);
}
