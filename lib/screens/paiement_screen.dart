import 'package:flutter/material.dart';
import '../models/dette.dart';
import '../models/client.dart';
import '../models/paiement.dart';
import '../services/api_service.dart';

class PaiementScreen extends StatefulWidget {
  final Dette dette;
  final Client client;
  PaiementScreen({required this.dette, required this.client});

  @override
  _PaiementScreenState createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  final _montantCtrl = TextEditingController();

  void _ajouterPaiement() async {
    if (_montantCtrl.text.isEmpty) return;
    final montant = double.parse(_montantCtrl.text);

    final paiement = Paiement(
      montant: montant,
      date: DateTime.now().toString().substring(0, 10),
    );
    final det = widget.dette;
    det.paiements.add(paiement);
    final totalPaye = det.paiements.fold<double>(0, (sum, p) => sum + p.montant);
    final restant = det.montantDette - totalPaye;

    final updatedDette = Dette(
      id: det.id,
      clientId: det.clientId,
      date: det.date,
      montantDette: det.montantDette,
      montantPaye: totalPaye,
      montantRestant: restant,
      paiements: det.paiements,
    );
    await ApiService.updateDette(updatedDette);
    setState(() {
      _montantCtrl.clear();
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final det = widget.dette;
    return Scaffold(
      appBar: AppBar(title: Text('Paiements de la dette')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Dette: ${det.montantDette} FCFA', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Montant payé: ${det.montantPaye} FCFA'),
            Text('Montant restant: ${det.montantRestant} FCFA'),
            Divider(),
            Text('Historique des paiements:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...det.paiements.map((p) => ListTile(
              title: Text('${p.montant} FCFA'),
              subtitle: Text('Date: ${p.date}'),
            )),
            Divider(),
            TextField(
              controller: _montantCtrl,
              decoration: InputDecoration(labelText: 'Ajouter un paiement'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: _ajouterPaiement, child: Text('Valider')),
          ],
        ),
      ),
    );
  }
}
