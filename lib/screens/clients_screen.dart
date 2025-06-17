import 'package:flutter/material.dart';
import '../models/client.dart';
import '../services/api_service.dart';
import 'add_clients_screen.dart';
import 'dettes_screen.dart';

class ClientsScreen extends StatefulWidget {
  @override
  _ClientsScreenState createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late Future<List<Client>> clients;

  @override
  void initState() {
    super.initState();
    clients = ApiService.getClients();
  }

  void refresh() {
    setState(() {
      clients = ApiService.getClients();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clients')),
      body: FutureBuilder<List<Client>>(
        future: clients,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Aucun client.'));
          }
          final clients = snapshot.data!;
          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, i) {
              final c = clients[i];
              return ListTile(
                title: Text(c.nom),
                subtitle: Text('${c.telephone}\n${c.adresse}'),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => DettesScreen(client: c)
                    )
                  );
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context, MaterialPageRoute(builder: (_) => AddClientScreen()));
          refresh();
        },
        child: Icon(Icons.add),
        tooltip: 'Ajouter client',
      ),
    );
  }
}
