import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/api_service.dart';

class AddClientScreen extends StatefulWidget {
  @override
  _AddClientScreenState createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _adresseCtrl = TextEditingController();

  void _save() async {
    if (_formKey.currentState!.validate()) {
      await ApiService.addClient(
        Client(nom: _nomCtrl.text, telephone: _telCtrl.text, adresse: _adresseCtrl.text)
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajouter Client')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomCtrl,
                decoration: InputDecoration(labelText: 'Nom'),
                validator: (v) => v!.isEmpty ? 'Nom requis' : null,
              ),
              TextFormField(
                controller: _telCtrl,
                decoration: InputDecoration(labelText: 'Téléphone'),
                validator: (v) => v!.isEmpty ? 'Téléphone requis' : null,
              ),
              TextFormField(
                controller: _adresseCtrl,
                decoration: InputDecoration(labelText: 'Adresse'),
                validator: (v) => v!.isEmpty ? 'Adresse requise' : null,
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
