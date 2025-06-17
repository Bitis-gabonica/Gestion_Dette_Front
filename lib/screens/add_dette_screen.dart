import 'package:flutter/material.dart';
import '../models/client.dart';
import '../models/dette.dart';
import '../services/api_service.dart';

class AddDetteScreen extends StatefulWidget {
  final Client client;
  AddDetteScreen({required this.client});

  @override
  _AddDetteScreenState createState() => _AddDetteScreenState();
}

class _AddDetteScreenState extends State<AddDetteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montantCtrl = TextEditingController();

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final montant = double.parse(_montantCtrl.text);
      await ApiService.addDette(
        Dette(
          clientId: widget.client.id!,
          date: DateTime.now().toString().substring(0,10),
          montantDette: montant,
          montantPaye: 0,
          montantRestant: montant,
          paiements: [],
        )
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter Dette')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _montantCtrl,
                decoration: InputDecoration(labelText: 'Montant Dette (FCFA)'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Montant requis' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: Text('Enregistrer')),
            ],
          ),
        ),
      ),
    );
  }
}
