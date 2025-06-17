import 'package:flutter/material.dart';
import '../models/client.dart';
import '../models/dette.dart';
import '../services/api_service.dart';
import 'add_dette_screen.dart';
import 'paiement_screen.dart';

class DettesScreen extends StatefulWidget {
  final Client client;
  DettesScreen({required this.client});

  @override
  _DettesScreenState createState() => _DettesScreenState();
}

class _DettesScreenState extends State<DettesScreen> {
  late Future<List<Dette>> dettes;

  @override
  void initState() {
    super.initState();
    dettes = ApiService.getDettes(widget.client.id!);
  }

  void refresh() {
    setState(() {
      dettes = ApiService.getDettes(widget.client.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dettes de ${widget.client.nom}')),
      body: FutureBuilder<List<Dette>>(
        future: dettes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Erreur: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('Aucune dette.'));
          final dettes = snapshot.data!;
          return ListView.builder(
            itemCount: dettes.length,
            itemBuilder: (context, i) {
              final d = dettes[i];
              return ListTile(
                title: Text('${d.montantRestant} FCFA restant'),
                subtitle: Text('Dette: ${d.montantDette} | Payé: ${d.montantPaye}\nDate: ${d.date}'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (_) => PaiementScreen(dette: d, client: widget.client)
                  )).then((_) => refresh());
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
            MaterialPageRoute(builder: (_) => AddDetteScreen(client: widget.client)));
          refresh();
        },
        child: Icon(Icons.add),
        tooltip: 'Ajouter dette',
      ),
    );
  }
}
