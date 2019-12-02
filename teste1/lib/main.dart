import 'package:flutter/material.dart';
import 'package:teste1/telas/home.dart';
import 'package:teste1/telas/loading.dart';
import 'package:teste1/telas/vitoria.dart';
import 'package:teste1/telas/derrota.dart';
import 'package:teste1/telas/jogo.dart';
import 'package:teste1/servicos/login.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/login': (context) => Login(),
    '/home': (context) => Home(),
    '/vitoria': (context) => Vitoria(),
    '/derrota': (context) => Derrota(),
    '/jogo': (context) => Jogo(),
  },
));
