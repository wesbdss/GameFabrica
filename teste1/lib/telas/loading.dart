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
    Navigator.pushReplacementNamed(context, '/login', arguments: {
      'nome': instance.nome,
      'vitoria': instance.vitoria,
      'derrota': instance.derrota,
      'ratio': instance.ratio,
      'pontos': instance.pontos,
      'credencial': instance.credencial,
    });
  }

  @override
  void initState(){
    super.initState();
    setupApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}
