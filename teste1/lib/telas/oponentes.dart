import 'package:flutter/material.dart';

class Oponentes extends StatefulWidget {
  @override
  _OponentesState createState() => _OponentesState();
}

class _OponentesState extends State<Oponentes> {

  Map dados = {};

  void jogar() {
    Navigator.pushReplacementNamed(context, '/jogo', arguments: dados);
  }

  @override
  Widget build(BuildContext context) {

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
