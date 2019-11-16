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
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            /*image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )*/
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Text(
                  'dados',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.red[900],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      dados['nome'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  dados['pontos'].toString(),
                ),
                SizedBox(height: 500.0),
                FlatButton(
                  child: Text(
                    'Jogar',
                  ),
                  onPressed: () async {
                    dynamic resultado = await Navigator.pushReplacementNamed(context, '/pareamento');
                    if(resultado != null){
                      setState(() {
                        dados = {
                          'pontos': resultado['pontos'],
                          'vitoria': resultado['vitoria'],
                          'derrota': resultado['derrota'],
                          'ratio': resultado['ratio'],
                        };
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
        ),
    );
  }
}
