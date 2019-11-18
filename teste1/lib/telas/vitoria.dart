import 'package:flutter/material.dart';

class Vitoria extends StatefulWidget {
  @override
  _VitoriaState createState() => _VitoriaState();
}

class _VitoriaState extends State<Vitoria> {

  void voltarHome() {
    print('voltando pra tela home');
    Navigator.pushReplacementNamed(context, '/home', arguments: dados);
  }

  Map dados = {};
  
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
            ),
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
                      'Tela Vitoria',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                        color: Colors.yellow,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                SizedBox(height: 100.0),
                RaisedButton(
                  child: Text('voltar'),
                  onPressed: () {voltarHome();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
