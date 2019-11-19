import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map dados = {};

  void parear() {
    Navigator.pushReplacementNamed(context, '/pareamento', arguments: dados);
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    
    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    String bgImage = 'home.jpg';
    Color bgColor = Colors.black; // isso põe cor na barra onde ficam os dados do celular

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
                SizedBox(height: 222.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dados['nome'].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Text(
                  //dados['vitoria'].toString(),
                  '10',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  //dados['derrota'].toString(),
                  '2',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 25.0),
                Text(
                  dados['pontos'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 40.0),
                GestureDetector(
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image:AssetImage("assets/search.png"), 
                        fit:BoxFit.cover
                      ),
                    ),
                  ),onTap:(){
                    parear();
                  }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}