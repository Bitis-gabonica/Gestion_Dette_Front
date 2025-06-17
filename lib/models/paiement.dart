class Paiement {
  final int? id;
  final double montant;
  final String date;

  Paiement({this.id, required this.montant, required this.date});

  factory Paiement.fromJson(Map<String, dynamic> json) => Paiement(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        montant: (json['montant'] as num).toDouble(),
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'montant': montant,
        'date': date,
      };
}

