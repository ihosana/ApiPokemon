import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:terceira_prova/model/PokemonBD.dart';
import 'package:terceira_prova/model/PokemonDAO.dart';
import 'package:terceira_prova/model/PokemonGo.dart';

part 'Database.g.dart';

@Database(version: 1, entities: [PokemonGo])
abstract class DatabaseHelper extends FloorDatabase{
  PokemonDao get pokemonDao;
}

