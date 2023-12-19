import 'package:floor/floor.dart';
import 'package:terceira_prova/model/PokemonGo.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM PokemonGo')
  Future<List<PokemonGo>> getAll();

  @insert
  Future<int> insertPokemon(PokemonGo pokemon);

  @update
  Future<void> updatePokemon(PokemonGo pokemon);

  @delete
  Future<void> deletePokemon(PokemonGo pokemon);
}
