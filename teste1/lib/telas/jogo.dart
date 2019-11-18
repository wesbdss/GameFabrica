import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  Map dados = {};

  void perdeu() {
    print('indo pra tela de derrota');
    Navigator.pushReplacementNamed(context, '/derrota', arguments: dados);
  }

  void ganhou() {
    print('indo pra tela de vitória');
    Navigator.pushReplacementNamed(context, '/vitoria', arguments: dados);
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
                      'Jogo',
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
                  child: Text('ganhei'),
                  onPressed: () {ganhou();},
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('perdi'),
                  onPressed: () {perdeu();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}