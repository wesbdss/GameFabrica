import 'package:flutter/material.dart';
import 'package:teste1/servicos/pareamento.dart';
import 'package:teste1/telas/home.dart';
import 'package:teste1/telas/loading.dart';
import 'package:teste1/telas/vitoria.dart';
import 'package:teste1/telas/derrota.dart';
import 'package:teste1/telas/placar.dart';
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
    '/placar': (context) => Placar(),
    '/jogo': (context) => Jogo(),
    '/pareamento': (context) => Pareamento(),
  },
));
