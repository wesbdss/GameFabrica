import 'package:flutter/material.dart';
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
    Conexao instance = Conexao();
    //await instance.getInfo();
    await instance.connect();
    Navigator.pushReplacementNamed(context, '/login', arguments: {
      'channel': instance.channel,
    });
  }

  @override
  void initState(){
    super.initState();
    setupApp();
  }

  @override
  Widget build(BuildContext context) {

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
                SizedBox(height: 150.0),
                Text(
                  'Loading . . .',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                    letterSpacing: 5.0,
                  ),
                ),
                SizedBox(height: 200.0),
                SpinKitFadingCube(
                  color: Colors.white,
                  size: 60.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
