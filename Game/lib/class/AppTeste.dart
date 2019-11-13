import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/foundation.dart';

class Teste extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Danger Is Near',
      theme: ThemeData(primarySwatch: Colors.green),
      home: MyTestePage(
        title: 'Teste pingulin',
      ),
    );
  }
}

class MyTestePage extends StatefulWidget {
  MyTestePage({Key key, this.title}) : super(key: key);
  final String title;
  final channel = IOWebSocketChannel.connect('ws://192.168.0.106:8080');

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
    widget.channel.sink.add(mes);
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
          decoration: InputDecoration(labelText: 'Teste ${widget.channel}'),
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
      ]),
    );
  }
}
