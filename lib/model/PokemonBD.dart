import 'package:floor/floor.dart';

@Entity()
class PokemonBD {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String nome;
  final String altura;
  final String peso;
  final int forca;
  final bool isCadastrado;
  final String imageUrl;
  PokemonBD(this.id, this.nome, this.altura, this.peso, this.forca, this.isCadastrado, this.imageUrl);
}