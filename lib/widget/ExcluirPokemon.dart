import 'package:flutter/material.dart';
import 'package:terceira_prova/database/Database.dart';
import 'package:terceira_prova/model/PokemonDAO.dart';
import 'package:terceira_prova/model/PokemonGo.dart';
import 'package:terceira_prova/widget/Home.dart';
import 'package:terceira_prova/widget/TelaCaptura.dart';
import 'package:terceira_prova/widget/TelaHome.dart';
import 'package:terceira_prova/widget/TelaSobre.dart';

class SoltarPokemon extends StatelessWidget {
  final PokemonGo pokemon;
  late DatabaseHelper databaseHelper;
  late PokemonDao dao;
  SoltarPokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina de Excluir'),
         backgroundColor: Color.fromARGB(255, 10, 75, 160),
          foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: initializeDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return Card(
            margin: EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                pokemon.imageUrl, // Substitua isso pela URL da imagem do Pokémon
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
                Text(
                        "Id:" +
                            pokemon.id.toString(), // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Nome:" + pokemon.nome, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Altura:" +
                            pokemon.altura, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Peso:" + pokemon.peso, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cadastrado:"+pokemon.isCadastrado.toString(), // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Adicione aqui a lógica para soltar o Pokémon
                          dao.deletePokemon(pokemon);
                          print('Pokémon solto!');
                         
                           Navigator.pop(context, true); // Fechar a tela após soltar
                          
                        },
                        child: Text('Soltar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Adicione aqui a lógica para cancelar a operação
                          print('Operação cancelada');
                          Navigator.pop(context); // Fechar a tela ao cancelar
                        },
                        child: Text('Cancelar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> initializeDatabase() async {
    databaseHelper =
        await $FloorDatabaseHelper.databaseBuilder('PokemonGo.db').build();
    dao = databaseHelper.pokemonDao;
  }
}
