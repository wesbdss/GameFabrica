import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map dados = {};

  @override
  Widget build(BuildContext context) {
    
    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    //String bgImage = 'caminho da imagem';
    //String bgColor = Colors.black; isso põe cor na barra onde ficam os dados do celular

    return Scaffold(
      
    );
  }
}
