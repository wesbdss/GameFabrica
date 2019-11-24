import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  String nome, msg;

  void perdeu() {
    print('indo pra tela de derrota');
    Navigator.pushReplacementNamed(context, '/derrota', arguments: nome);
  }

  void ganhou() {
    print('indo pra tela de vitória');
    Navigator.pushReplacementNamed(context, '/vitoria', arguments: nome);
  }

  void enviar() async {
    Conexao instance = Conexao();
    await instance.enviando(msg);
  }

  void inputMsg(String valor) {
    setState(() {
      msg = valor;
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);


    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    nome = ModalRoute.of(context).settings.arguments;

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
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    hintText: 'Usuário',
                    hintStyle: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  autocorrect: false,
                  onChanged: (String valor) {inputMsg(valor);},
                ),
                SizedBox(height: 35.0),
                RaisedButton(
                  child: Text('OK'),
                  onPressed: () {enviar();},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}