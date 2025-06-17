import 'paiement.dart';

class Dette {
  final int? id;
  final int clientId;
  final String date;
  final double montantDette;
  final double montantPaye;
  final double montantRestant;
  final List<Paiement> paiements;

  Dette({
    this.id,
    required this.clientId,
    required this.date,
    required this.montantDette,
    required this.montantPaye,
    required this.montantRestant,
    required this.paiements,
  });

  factory Dette.fromJson(Map<String, dynamic> json) => Dette(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        clientId: json['clientId'] != null ? int.tryParse(json['clientId'].toString()) ?? 0 : 0,
        date: json['date'],
        montantDette: (json['montantDette'] as num).toDouble(),
        montantPaye: (json['montantPaye'] as num).toDouble(),
        montantRestant: (json['montantRestant'] as num).toDouble(),
        paiements: (json['paiements'] as List).map((e) => Paiement.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clientId': clientId,
        'date': date,
        'montantDette': montantDette,
        'montantPaye': montantPaye,
        'montantRestant': montantRestant,
        'paiements': paiements.map((e) => e.toJson()).toList(),
      };
}
