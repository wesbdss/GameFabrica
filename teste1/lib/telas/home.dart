import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static Map dados = {};
  Map dadosOp = {};
 
  var x = json.encode({"username": dados['nome'],"function":"firstin"});
  
  void parear() async {
    //desativar botao aqui !!
    print("(Home) -> Conectando com servidor");
    WebSocketChannel channel = IOWebSocketChannel.connect('ws://lit-fortress-57323.herokuapp.com/event');
    channel.sink.add(json.encode({"function":"jogar","username": dados['nome']}));
    print("(Home) -> Procurando Oponente");
    channel.stream.listen((message) {
      var result = json.decode(message);
      if (result['response'] == "encontrado"){
        dadosOp = {
          'nomeOp': result['usernameOP'],
          'pontosOp': result['pontos'],
          'vitoriasOp': result['vitorias'],
          'derrotasOp': result['derrotas'],
        };
        print("OPONENTE ENCONTRADO -> ${result['usernameOP']}");
        WebSocketChannel channel2 = IOWebSocketChannel.connect('ws://lit-fortress-57323.herokuapp.com/event');
        channel2.sink.add(json.encode({"function":"ingame","username": "${dados['nome']}","nomeOP":"${dadosOp['nomeOp']}"}));
        Map channelM = {
          'channel': channel2,
        };
        Map concat = {}..addAll(dados)..addAll(dadosOp)..addAll(channelM);
        Navigator.pushReplacementNamed(context, '/jogo', arguments: concat);
        channel.sink.close(status.goingAway);
      }
    });  
  }  
  
  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    
    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    //print(dados['nome']);

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
                    )
                  ],
                ),
                SizedBox(height: 25.0),
                Text(
                  dados['vitoria'].toString(),
                  //'10',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 30.0),
                Text(
                  dados['derrota'].toString(),
                  //'2',
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
