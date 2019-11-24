import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste1/servicos/conexao.dart';

class Pareamento extends StatefulWidget {
  @override
  _PareamentoState createState() => _PareamentoState();
}

class _PareamentoState extends State<Pareamento> {

  Map dados = {};
  Map op = {};

  void parear () async {
    Conexao instance = Conexao();
    await instance.getInfoInimigo();
    op = {
      'nomesOp': instance.nomesOp,
      'pontosOp': instance.pontosOp,
      'vitoriasOp': instance.vitoriasOp,
      'derrotasOp': instance.derrotasOp,
    };
    Map name = {'nome': dados['nome']};
    Map concat = {}..addAll(op)..addAll(name);
    Navigator.pushReplacementNamed(context, '/oponentes', arguments: concat);
  }

  @override
  void initState(){
    super.initState();
    parear();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 150.0),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    letterSpacing: 5.0,
                  ),
                ),
                SizedBox(height: 200.0),
                SpinKitFadingCube(
                  color: Colors.white,
                  size: 60.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}