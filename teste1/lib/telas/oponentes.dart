import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Oponentes extends StatefulWidget {
  @override
  _OponentesState createState() => _OponentesState();
}

class _OponentesState extends State<Oponentes> {

  Map op = {};
  var trocar = 0;
  String nome;

  void jogar() {
    nome = op['nome'].toString();
    Navigator.pushReplacementNamed(context, '/jogo', arguments: nome);
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    op = op.isNotEmpty ? op : ModalRoute.of(context).settings.arguments;

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
