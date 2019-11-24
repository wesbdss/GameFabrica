import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste1/servicos/conexao.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  /* 
    Função que vai esperar a conexão com o servidor ser estabelecida
    O servidor deve retornar: conexão bem sucedida ou não
  */
  

  void setupApp() async {
    //await instance.getInfo();
    Conexao instance = Conexao();
    await instance.roleplay();
    Navigator.pushReplacementNamed(context, '/login', arguments: {
      'nome': 'a',
    });
  }

  @override
  void initState(){
    super.initState();
    setupApp();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 25.0),
                Logo(),
                SizedBox(height: 100.0),
                Texto(),
                SizedBox(height: 200.0),
                SpinKit(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Texto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Loading . . .',
        style: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
          letterSpacing: 5.0,
        ),
      ),
    );
  }
}

class SpinKit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitFadingCube(
        color: Colors.white,
        size: 60.0,
      ),
    );
  }
}

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/logo.png',
        height: 150.0,
        width: 200.0
      ),
    );
  }
}