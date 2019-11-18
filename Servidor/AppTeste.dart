import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';
// n esquece da porra do IP certo (externo)
// var encode = json.encode({'comi':'sua mae'});
    // print(dados['channel'].sink.add(encode));
    // dados['channel'].stream.listen((message) {
    //   var decode = json.decode(message);
    //   print(decode['response']);
    // });

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danger Is Near',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyTestePage(
        title: 'Teste pingulin',
        channel: IOWebSocketChannel.connect('ws://localhost:8080'),
      ),
    );
  }
}

class MyTestePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  
  @override
  _MyTestePageState createState() => _MyTestePageState();
}

class _MyTestePageState extends State<MyTestePage> {
  int _counter = 0;
  String _nome = "Wesley";
  String _child = "Teste";
  

  final control = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _sendMessage(String mes){
    channel.sink.add(mes);
  }

  void _disconect(){
    setState(() {
          _nome = "Não tem conexão!";
        });
    }
  

  @override
  Widget build(BuildContext context) {
    return meuWidget2();
  }

  Widget teste() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem Vindo: $_nome"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () => setState(() {
            _counter++;
            _nome = "Você clicou $_counter vezes";
          }),
          child: Image.asset('images/01.gif'),
        ),
      ),
      backgroundColor: Colors.red,
    );
  }

  Widget meuWidget() {
    return Center(
        child: Container(
      decoration: BoxDecoration(
        color: const Color(0xff7c94b6),
        image: DecorationImage(
          image: ExactAssetImage('images/perfil.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ));
  }

  Widget meuWidget2() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste de Backend"),
      ),
      body: Column(children: <Widget>[
        Text('Teste Back end do $_nome'),
        Center(
            child: TextField(
          decoration: InputDecoration(labelText: 'Teste ${channel}'),
          controller: control,
        )),
        IconButton(
            icon: Image.asset('images/01.gif'),
            onPressed: () {
              _sendMessage(control.text);
              setState(() {
                _nome = control.text;
              });
            }),
            IconButton(
              icon: Image.asset('images/perfil.png'),
              onPressed: (){
                _connect('192.168.0.101:8080');
              }
            ),
      ]),
    );
  }
}
