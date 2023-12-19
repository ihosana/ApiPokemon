import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:terceira_prova/widget/Home.dart';


import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:terceira_prova/widget/TelaCaptura.dart';
void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => Home();
}

