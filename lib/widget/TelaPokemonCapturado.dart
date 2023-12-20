import 'package:flutter/material.dart';
import 'package:terceira_prova/database/Database.dart';
import 'package:terceira_prova/model/PokemonDAO.dart';
import 'package:terceira_prova/model/PokemonGo.dart';
import 'package:terceira_prova/widget/Card.dart';
import 'package:terceira_prova/widget/ExcluirPokemon.dart';
import 'package:terceira_prova/widget/TelaDetalhes.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  TelaPokemonCapturadoState createState() => TelaPokemonCapturadoState();
}

class TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late DatabaseHelper databaseHelper;
  late PokemonDao dao;
  late List<PokemonGo> pokemons = []; // Inicialize com uma lista vazia
  bool clicou = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      initializeDatabase();
    });
  }

  void initializeDatabase() async {
    databaseHelper =
        await $FloorDatabaseHelper.databaseBuilder('PokemonGo.db').build();
    dao = databaseHelper.pokemonDao;
    await listarPokemons();
  }

  Future<void> listarPokemons() async {
    pokemons = await dao.getAll();
    setState(
        () {}); // Atualize o estado após recuperar os pokémons do banco de dados
  }

  @override
  Widget build(BuildContext context) {
    // Verifique se a lista de pokémons não é nula antes de acessá-la
    if (pokemons.isEmpty) {
      return Center(
        child: Text("Nenhum pokemon cadastrado"),
      );
    }

    // TODO: implement build
    return ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) => Gesto(
              pokemon: pokemons[index],
            ));
  }
}

// itemBuilder: (context, i) => ListItem(contato: snapshot.data![i]),
class Gesto extends StatelessWidget {
  final PokemonGo pokemon;
  Gesto({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 80,
        width: 80,
        child: GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Toque simples...."),
              ));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaDetalhes(
                          name: pokemon.nome,
                          imagem: pokemon.imageUrl,
                          id: pokemon.id,
                          altura: pokemon.altura,
                          peso: pokemon.peso,
                          cadastrado: pokemon.isCadastrado,
                        )),
              );
            },
            onLongPress: () {
              //DELETARRR
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Toque longo"),
              ));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SoltarPokemon(pokemon: pokemon)),
              ).then((result) {
                if (result != null && result is bool && result) {
                  TelaPokemonCapturadoState telaState = context
                      .findAncestorStateOfType<TelaPokemonCapturadoState>()!;
                  telaState.listarPokemons();
                }
              });
            },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(pokemon.imageUrl)),
                title: Text(pokemon.nome),
                subtitle: Text("id: " + pokemon.id.toString()),
              ),
            )));
  }
}
