
import 'dart:async';
import 'dart:developer' as developer;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:terceira_prova/main.dart';
import 'package:terceira_prova/model/Pokemon.dart';
import 'package:terceira_prova/widget/Card.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Title(
                color: Colors.black,
                child: const Text("Pagina Sobre",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 26))),
            Title(
                color: Colors.black,
                child: const Text("Desenvolvedores:",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            const Padding(
                padding: EdgeInsets.only(right: 10, top: 40),
                child: Column(
                  children: [
                    Text("Ihosana de Assis,"),
                    
                    Text("Rodrigo Pacheco,")
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
