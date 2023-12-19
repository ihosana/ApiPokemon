import 'package:flutter/material.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/widget/Card.dart';

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

              final List<dynamic> forms = id['forms'] as List<dynamic>;
              final Map<String, dynamic> firstForm = forms.first;
              final String pokemonUrl = firstForm['url'];
              print(numerosSorteados[index]);
             
              final List<dynamic> stats = id['stats'] as List<dynamic>;

             

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
                    id: numerosSorteados[index]
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
