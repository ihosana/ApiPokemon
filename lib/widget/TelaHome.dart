import 'package:flutter/material.dart';

class TelaHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Center(
        child: Text('Lets play Pokemon GO! Please, press the button'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicione aqui a lógica que deseja executar quando o botão for pressionado
          print('Botão pressionado!');
        },
        child: Icon(Icons.catching_pokemon_outlined,
        color: Color.fromARGB(255, 234, 52, 6),
        size: 40.0,
        ),
      ),
    );
  }
}