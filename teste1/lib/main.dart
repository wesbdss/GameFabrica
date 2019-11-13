import 'package:flutter/material.dart';
import 'package:teste1/telas/home.dart';
import 'package:teste1/telas/loading.dart';
import 'package:teste1/telas/vitoria.dart';
import 'package:teste1/telas/derrota.dart';
import 'package:teste1/telas/placar.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/vitoria': (context) => Vitoria(),
    '/derrota': (context) => Derrota(),
    '/placar': (context) => Placar(),
  },
));
