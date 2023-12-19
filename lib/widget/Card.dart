import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/widget/Pokebola.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/widget/Pokebola.dart';

class PokemonItem extends StatefulWidget {
  final String name;
  final String imageUrl;

  PokemonItem({required this.name, required this.imageUrl});

  @override
  _PokemonItemState createState() => _PokemonItemState();
}

class _PokemonItemState extends State<PokemonItem> {
  bool clicou = true;
  
 void apertouNoBotao() {
    // Faça algo quando o botão for pressionado
    print('Botão pressionado');
    
    // Atualize o estado para desativar o botão
    setState(() {
       clicou= false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.imageUrl),
        ),
        title: Text(widget.name),
        trailing: PokebolaButton(
          onPressed:(){clicou ? apertouNoBotao() : null;}, 
          ativado: clicou ,
        ),
      ),
    );
  }

 
}




