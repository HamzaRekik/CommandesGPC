class Produit {
  String? id;
  String? type;
  String? name;

  Produit({
    required this.id,
    required this.type,
    required this.name,
  });

  factory Produit.formJson(Map<String, dynamic> json) =>
      Produit(id: json['id'], type: json['type'], name: json['name']);
}
