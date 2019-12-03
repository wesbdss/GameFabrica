import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class Derrota extends StatefulWidget {
  @override
  _DerrotaState createState() => _DerrotaState();
}

class _DerrotaState extends State<Derrota> {

  void voltarHome(Map d) async{
    print('voltando pra tela home');
    print(d['pontosR']);
    print(d['pontos']);
    int pontos = d['pontos'] - d['pontosR'];
    if(pontos < 0){
      pontos = 0;
    }
    print("Pontos: ");
    print(pontos);
    int derrota = d['derrota'] + 1;
    print("Derrota: ");
    print(derrota);
    final response = await http.post("http://lit-fortress-57323.herokuapp.com/",
    headers: {"Content-type": "application/json"},
    body: json.encode({"function": "setInfo","username":"${d['nome']}","pontos":pontos.toString(),"vitoria":"${d['vitoria']}","derrota":derrota.toString()}));
    Map defeat = {
      'nome': d['nome'],
      'vitoria': d['vitoria'],
      'derrota': derrota.toString(),
      'pontos': pontos.toString()
    };
    Navigator.pushReplacementNamed(context, '/home', arguments: defeat);
  }

  Conexao instance = Conexao();

  void getDados(Map data) async {
    String nome = data ['nome'];
    await instance.getInfo(nome);
    dados = {
      'nome': instance.nome,
      'vitoria': instance.vitoria,
      'derrota': instance.derrota,
      'pontos': instance.pontos,
    };
  }

  Map dados = {};

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
        
    dados = ModalRoute.of(context).settings.arguments;
    //getDados(dados);
    print("Dados");
    print(dados);
    print(dados['pontosR']);

    String bgImage = 'fundoLoss.jpg';
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
                GameOver(),
                Trofeu(),
                Defeat(),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Star(),
                    SizedBox(width: 5.0),
                    Pontos(),
                    SizedBox(width: 12.0),
                    Text(
                      dados['pontosR'].toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                RaisedButton(
                  child: Text('voltar'),
                  onPressed: () {voltarHome(dados);},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Trofeu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //AssetImage trofeu = AssetImage('assets/trophyWin.png');
    //Image image = Image(image: trofeu, width: 10, height: 20,);
    return Container(
      child: Image.asset(
        'assets/trophyWin.png',
        height: 150.0,
        width: 200.0
      ),
    );
  }
}

class GameOver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/gameover.png',
        height: 100.0,
        width: 150.0,
      ),
    );
  }
}

class Defeat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/defeat.png',
        height: 100.0,
        width: 150.0,
      ),
    );
  }
}

class Star extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/star.png',
        height: 20.0,
        width: 20.0,
      ),
    );
  }
}

class Pontos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/pontos.png',
        height: 20.0,
        width: 80.0,
      ),
    );
  }
}
