
import 'package:flutter/material.dart';

class PokebolaButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool ativado;
  final bool cadastrado;
  PokebolaButton({required this.onPressed, required this.ativado, required this.cadastrado});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: cadastrado==false ? Colors.red : Colors.grey,
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: const Center(
          child: Icon(
            Icons.catching_pokemon,
            color: Colors.white,
            size: 40.0,
          ),
        ),
      ),
    );
  }
}