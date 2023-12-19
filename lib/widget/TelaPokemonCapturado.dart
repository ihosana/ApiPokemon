import 'package:flutter/material.dart';
import 'package:terceira_prova/database/Database.dart';
import 'package:terceira_prova/model/PokemonDAO.dart';
import 'package:terceira_prova/model/PokemonGo.dart';
import 'package:terceira_prova/widget/Card.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  TelaPokemonCapturadoState createState() => TelaPokemonCapturadoState();
}
class TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late PokemonGo pokemonGo;
  late DatabaseHelper databaseHelper;
  late PokemonDao dao;
  late List<PokemonGo> pokemons = []; // Inicialize com uma lista vazia
  bool clicou = true;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  void initializeDatabase() async {
    databaseHelper = await $FloorDatabaseHelper
        .databaseBuilder('PokemonGo.db')
        .build();
    dao = databaseHelper.pokemonDao;
    await listarPokemons();
  }

  Future<void> listarPokemons() async {
    pokemons = await dao.getAll();
    setState(() {}); // Atualize o estado após recuperar os pokémons do banco de dados

  
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
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokemonItem(
          name: pokemon.nome,
          imageUrl: "", id: index,
        );
      },
    );
  }
}


// itemBuilder: (context, i) => ListItem(contato: snapshot.data![i]),
class Gesto extends StatelessWidget {
  final PokemonGo pokemon;
   Gesto({super.key, required this.pokemon});
  
  @override
  Widget build(BuildContext context) {
   
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Single Tap"),
          
        ));
      },
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Long Press"),
        ));
          Card(
         child:  ListTile(
          leading: CircleAvatar( 
          backgroundImage: NetworkImage(pokemon.imageUrl)
          ),
           title: Text(pokemon.nome),
           subtitle: Text("id: "+pokemon.id.toString()),
           
        ),
        );
      },
       
    );
    
  }
} 