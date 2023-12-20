import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/widget/Card.dart';

import 'dart:io';
import 'package:http/http.dart' as http;
class TelaCaptura extends StatelessWidget {
  List<int> numerosSorteados = [];
  int cont = 0;
  TelaCaptura({super.key, required this.numerosSorteados});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: FutureBuilder(
        future: Pokemon.fetchPokemonList(numerosSorteados),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro snapshort: " + snapshot.error.toString()),
            );
          }

          final List<Map<String, dynamic>> pokemons =
              snapshot.data as List<Map<String, dynamic>>;

          return ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              final id = pokemons[index];
              final pokemonName = id['name'];
               final altura= id['height'];
              final peso=id['weight'];
              final List<dynamic> forms = id['forms'] as List<dynamic>;
              final Map<String, dynamic> firstForm = forms.first;
              final String pokemonUrl = firstForm['url'];
              
              //final Future<Pokemon> lista= Pokemon.fetchPokemon(numerosSorteados[index]);

              final url = 'https://pokeapi.co/api/v2/pokemon/$numerosSorteados[index]';
      
              return FutureBuilder(
                future: Pokemon.getPokemonImage(pokemonUrl),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator.adaptive();
                  }
                  if (imageSnapshot.hasError) {
                    return Text("Erro aqui" + imageSnapshot.error.toString());
                  }

                  final String imageUrl = imageSnapshot.data as String;

                  // print(numerosSorteados);
                  return PokemonItem(
                    imageUrl: imageUrl,
                    name: pokemonName,
                    id: numerosSorteados[index],
                    altura:altura.toString(),
                    peso:peso.toString()
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}



/*
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // URL da API do Pokémon
  final url = 'https://pokeapi.co/api/v2/pokemon/2';

  // Fazendo a requisição HTTP
  final response = await http.get(Uri.parse(url));

  // Verificando se a resposta foi bem-sucedida
  if (response.statusCode == 200) {
    // Decodificando o JSON
    final Map<String, dynamic> pokemonData = jsonDecode(response.body);

    // Navegando até a propriedade "height"
    final double height = pokemonData['height'] / 10; // Convertendo para metros
    print('Altura do Pokémon: $height metros');
  } else {
    print('Falha ao carregar dados do Pokémon');
  }
}
 */