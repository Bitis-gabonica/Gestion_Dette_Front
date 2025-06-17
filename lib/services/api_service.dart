import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/client.dart';
import '../models/dette.dart';

class ApiService {
  static const String apiUrl = 'http://localhost:3000'; 

  // Clients
  static Future<List<Client>> getClients() async {
    final response = await http.get(Uri.parse('$apiUrl/clients'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => Client.fromJson(e)).toList();
    }
    throw Exception('Erreur chargement clients');
  }

  static Future<Client> addClient(Client client) async {
    final response = await http.post(
      Uri.parse('$apiUrl/clients'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(client.toJson()),
    );
    if (response.statusCode == 201) {
      return Client.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur ajout client');
  }

  // Dettes
  static Future<List<Dette>> getDettes(int clientId) async {
    final response = await http.get(Uri.parse('$apiUrl/dettes?clientId=$clientId'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((e) => Dette.fromJson(e)).toList();
    }
    throw Exception('Erreur chargement dettes');
  }

  static Future<Dette> addDette(Dette dette) async {
    final response = await http.post(
      Uri.parse('$apiUrl/dettes'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dette.toJson()),
    );
    if (response.statusCode == 201) {
      return Dette.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur ajout dette');
  }

  static Future<Dette> updateDette(Dette dette) async {
    final response = await http.put(
      Uri.parse('$apiUrl/dettes/${dette.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(dette.toJson()),
    );
    if (response.statusCode == 200) {
      return Dette.fromJson(json.decode(response.body));
    }
    throw Exception('Erreur maj dette');
  }
}
