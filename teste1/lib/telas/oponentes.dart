import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';


class Oponentes extends StatefulWidget {
  @override
  _OponentesState createState() => _OponentesState();
}

class _OponentesState extends State<Oponentes> {

  Map dados = {};
  Map op = {};
  Map concat = {};
  String nome;

  void jogar() {
    //nome = op['nome'].toString();
    Navigator.pushReplacementNamed(context, '/jogo', arguments: concat);
  }

  void parear () async {
    Conexao instance = Conexao();
    await instance.getInfoInimigo();
    op = {
      'nomesOp': instance.nomesOp,
      'pontosOp': instance.pontosOp,
      'vitoriasOp': instance.vitoriasOp,
      'derrotasOp': instance.derrotasOp,
    };
    Map dados2 = {'nome': dados['nome'], 'connection': dados['channel']};
    concat = {}..addAll(op)..addAll(dados2);
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

    print("op: " + dados['channel']);
    print(dados);

    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    //op = op.isNotEmpty ? op : ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Oponentes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.yellow,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 100.0),
                RaisedButton(
                  child: Text('jogar'),
                  onPressed: () {jogar();},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
