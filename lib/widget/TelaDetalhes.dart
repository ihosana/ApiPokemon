import 'package:flutter/material.dart';

class TelaDetalhes extends StatelessWidget {
  final String imagem;
  final String name;
  final int id;
  final String altura;
  final String peso;
  final bool cadastrado;
  TelaDetalhes(
      {required this.imagem,
      required this.name,
      required this.id,
      required this.altura,
      required this.peso,
      required this.cadastrado});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Detalhes do pokemon ' + name),
          backgroundColor: Color.fromARGB(255, 10, 75, 160),
          foregroundColor: Colors.white,
        ),
        body: Card(
          margin: EdgeInsets.all(16.0),
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imagem, // Substitua isso pela URL da imagem do Pokémon
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Id:" +
                            id.toString(), // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Nome:" + name, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Altura:" +
                            altura, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Peso:" + peso, // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Cadastrado: $cadastrado", // Substitua isso pelo nome do Pokémon
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                       SizedBox(height: 16.0),
                    ],
                  )),
            ],
          ),
        ));
  }
}
