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
    O servidor deve retornar: nome, vit, der, %v/d, pontos
  */
  void setupApp() async {
    Conexao instance = Conexao();
    await instance.getInfo();
    await instance.connect();
    Navigator.pushReplacementNamed(context, '/login', arguments: {
      'nome': instance.nome,
      'vitoria': instance.vitoria,
      'derrota': instance.derrota,
      'ratio': instance.ratio,
      'pontos': instance.pontos,
      'credencial': instance.credencial,
      'channel':instance.channel,
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
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 60.0,
          ),
        ),
      ),
    );
  }
}