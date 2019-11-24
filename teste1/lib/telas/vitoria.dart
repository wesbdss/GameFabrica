import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';

class Vitoria extends StatefulWidget {
  @override
  _VitoriaState createState() => _VitoriaState();
}

class _VitoriaState extends State<Vitoria> {

  String nome;

  void voltarHome() {
    print('voltando pra tela home');
    Navigator.pushReplacementNamed(context, '/home', arguments: dados);
  }

  Conexao instance = Conexao();

  void getDados(String nome) async {
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

    nome = ModalRoute.of(context).settings.arguments;

    getDados(nome);

    String bgImage = 'fundoWin.jpg';
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
                Victory(),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Star(),
                    SizedBox(width: 5.0),
                    Pontos(),
                  ],
                ),
                SizedBox(height: 50.0),
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

class Victory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/victory.png',
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
