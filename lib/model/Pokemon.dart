import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  // Método de fábrica para criar uma instância de Pokemon a partir de dados JSON
  factory Pokemon.fromJson(Map<String, dynamic> json) {
      final urlSegments = json['url'].split('/');
    final id = int.parse(urlSegments[urlSegments.length - 2]);
    return Pokemon(
      id: id,
      name: json['name'],
      imageUrl: json["url"],
    );
  }

  // Método estático para buscar um Pokémon da API usando um ID
  static Future<Pokemon> fetchPokemon(int id) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }

  static Future<List<Map<String, dynamic>>> getPokemon() async {
    try {
      final res = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon/'),
      );

      if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }

      final data = jsonDecode(res.body)['results'];
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<String> getPokemonImage(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> pokemonDetails = jsonDecode(response.body);
      final String imageUrl = pokemonDetails['sprites']['front_default'];
      return imageUrl;
    } else {
      throw 'Erro ao obter a imagem do Pokémon';
    }
  }
  

 static Future<List<Map<String, dynamic>>> fetchPokemonList(List<int> pokemonNumbers) async {
    List<Map<String, dynamic>> pokemonList = [];

 try {
    
  for(int i in pokemonNumbers ){
    //print("numero sorteado"+i.toString());
final res = await http.get(
       Uri.parse('https://pokeapi.co/api/v2/pokemon/$i'),
      );
      final data = jsonDecode(res.body);
       if (res.statusCode != HttpStatus.ok) {
        throw 'Erro de conexão';
      }
       if (data.containsKey('name') && data['name'] != null) {
          pokemonList.add(data);
        }
  }
     
      return pokemonList;
    } catch (e) {
      throw e.toString();
    }
  }
}










/**
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
//part 'api.g.dart';

@JsonSerializable()
class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({required this.id, required this.name, required this.imageUrl});

  factory Pokemon.fromJson(Map<String, dynamic> json) => _$PokemonFromJson(json);

  static Future<Pokemon> fetchPokemon(String id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      return Pokemon.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load pokemon');
    }
  }
} */