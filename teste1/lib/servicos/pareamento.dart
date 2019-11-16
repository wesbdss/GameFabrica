import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste1/servicos/conexao.dart';

class Pareamento extends StatefulWidget {
  @override
  _PareamentoState createState() => _PareamentoState();
}

class _PareamentoState extends State<Pareamento> {
  void parear () async {
    Conexao instance = Conexao();
    await instance.getInfoInimigo();
    Navigator.pushReplacementNamed(context, '/jogo', arguments: {
      'nome': instance.nome,
      'vitoria': instance.vitoria,
      'derrota': instance.derrota,
      'ratio': instance.ratio,
      'pontos': instance.pontos,
    });
  }

  @override
  void initState(){
    super.initState();
    parear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}