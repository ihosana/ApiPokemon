// PokemonCard(id: 1, name:"Rodrigo", imageUrl: "https://media-for1-1.cdn.whatsapp.net/v/t61.24694-24/328783713_539393664770074_2583058071233276838_n.jpg?ccb=11-4&oh=01_AdS9KIXCsrl4FpuyYsUhIEf-U175YP0Bm82PALe8Juq38Q&oe=6588635E&_nc_sid=e6ed6c&_nc_cat=106");
import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terceira_prova/main.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/widget/Card.dart';
import 'package:terceira_prova/widget/TelaCaptura.dart';
import 'package:terceira_prova/widget/TelaPokemonCapturado.dart';
import 'package:terceira_prova/widget/TelaSobre.dart';

class Home extends State<MyApp> with TickerProviderStateMixin {
  List<Map<String, dynamic>> pokemons = [];

  bool _isLoading = false;
  bool _hasInternet = false;
  late TabController _tabController;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    Pokemon.getPokemon();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  List<int> sortearNumeros() {
    if (6 > 1017) {
      throw ArgumentError(
          'Quantidade de números a sortear maior que a faixa disponível.');
    }

    List<int> numerosSorteados = [];
    while (numerosSorteados.length < 6) {
      int numeroSorteado = Random().nextInt(1017 - 0 + 1) + 0;

      if (!numerosSorteados.contains(numeroSorteado)) {
        numerosSorteados.add(numeroSorteado);
      }
    }
    return numerosSorteados;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 10, 75, 160),
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            controller: _tabController,
            unselectedLabelColor: Colors.white,
            labelColor: Color.fromARGB(255, 250, 226, 12),
            tabs: const [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.catching_pokemon)),
              Tab(icon: Icon(Icons.data_saver_off)),
              Tab(icon: Icon(Icons.panorama_wide_angle_select_sharp)),
            ],
          ),
          title: const Text('Pokemon'),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 30, top: 10),
              child: Row(children: [Tab(icon: Icon(Icons.people_rounded))]),
            )
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const Icon(Icons.directions_car),
            Center(
                child: Column(
              children: [
                TextButton(
                  onPressed: () => _tabController.animateTo(0),
                  child: _connectionStatus != ConnectivityResult.none
                      ? TelaCaptura(numerosSorteados: sortearNumeros(),)
                      : Text('Sem conexão com a internet'),
                ),
              ],
            )),
            TelaPokemonCapturado(),
            TelaSobre(),
          ],
        ),
      ),
    );
  }
}
