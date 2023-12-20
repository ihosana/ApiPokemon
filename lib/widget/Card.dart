import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/database/Database.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/model/PokemonBD.dart';
import 'package:terceira_prova/model/PokemonDAO.dart';
import 'package:terceira_prova/model/PokemonGo.dart';
import 'package:terceira_prova/widget/Pokebola.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/widget/Pokebola.dart';
class PokemonItem extends StatefulWidget {
  final String name;
  final String imageUrl;
final int id;
final String altura;
final String peso;
 /*   final String altura;
  final String peso;
  final int forca;*/
  PokemonItem({required this.name, required this.imageUrl, required this.id, required this.altura, required this.peso});

  @override
  _PokemonItemState createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  late PokemonGo pokemonGo ;

  late List<PokemonGo> pokemons = [];
 late DatabaseHelper databaseHelper; 
   late PokemonDao dao;
  bool clicou = true;
  bool isCadastradoMudou=false;
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
  
  }

 void apertouNoBotao() async{

    setState(() {
       clicou= false;
       isCadastradoMudou=true;
       
           });
  pokemonGo =  PokemonGo(widget.id, widget.name,widget.altura , widget.peso, 200, isCadastradoMudou, widget.imageUrl);
    // Insira o PokemonBD no banco de dados
     dao.insertPokemon(pokemonGo);
    // Faça algo quando o botão for pressionado
    print(isCadastradoMudou);
    // Atualize o estado para desativar o botão
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar( 
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        title: Text(widget.name),
        trailing:
         PokebolaButton(

          onPressed:(){clicou ? apertouNoBotao() : null;}
          , 
          ativado: clicou ,
          cadastrado: isCadastradoMudou,
        ),
      ),
    );
  }

 
}
/*Future<bool> verificar()async{
   final pokemonJaExiste = await dao.getAll();
   for(var i in pokemonJaExiste){
      if(i.isCadastrado==true){
 return true ;
      }
   }
   return false;
 } */
