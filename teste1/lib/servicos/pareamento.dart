import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste1/servicos/conexao.dart';

class Pareamento extends StatefulWidget {
  @override
  _PareamentoState createState() => _PareamentoState();
}

class _PareamentoState extends State<Pareamento> {

  Map dados = {};

  void parear () async {
    Conexao instance = Conexao();
    await instance.getInfoInimigo();
    Navigator.pushReplacementNamed(context, '/jogo', arguments: dados);
  }

  @override
  void initState(){
    super.initState();
    parear();
  }

  @override
  Widget build(BuildContext context) {

    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

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