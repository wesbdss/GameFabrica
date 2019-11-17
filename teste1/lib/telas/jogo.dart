import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  @override
  Widget build(BuildContext context) {

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Text(
                  'Jogo',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.yellow,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100.0),
                RaisedButton(
                  child: Text('ganhei'),
                  onPressed: null,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  child: Text('perdi'),
                  onPressed: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}