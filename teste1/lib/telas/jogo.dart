import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  String msg;
  List <String> lista;
  Map dados = {};
  Map concat = {};

  void perdeu() {
    print('indo pra tela de derrota');
    Navigator.pushReplacementNamed(context, '/derrota', arguments: concat);
  }

  void ganhou() {
    print('indo pra tela de vitória');
    Navigator.pushReplacementNamed(context, '/vitoria', arguments: concat);
  }

  void enviar() async {
    lista += [msg];
    print(lista);
  }

  void encerrar(){
    dados['channel'].sink.add(json.encode({"function":"end"}));
    dados['channel'].stream.listen((message){
      var result = json.decode(message);
      if (result['response'] == "ok"){
        print("(Jogo) -> Servidor recebeu meu codigo");
      }
      if (result['response'] == "fim"){
        Map pontosResult = {};
        if (result['status'] == "1"){
          pontosResult = {
            
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          ganhou();
        }
        if (result['status'] == "0"){
          pontosResult = {
            
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          perdeu();
        }
        dados['channel'].sink.close(status.goingAway);
      }
    });
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

    dados = ModalRoute.of(context).settings.arguments;

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
                    hintText: 'Digite o código',
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