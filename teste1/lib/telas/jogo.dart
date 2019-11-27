import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/status.dart' as status;

class Jogo extends StatefulWidget {
  @override
  _JogoState createState() => _JogoState();
}

class _JogoState extends State<Jogo> with TickerProviderStateMixin {

  String bgImage = 'fundo.jpg';
  String msg;
  List <String> lista;
  final List<Code> lcode = <Code>[];
  final TextEditingController tedit = new TextEditingController();
  bool isComposing = false;
  Map dados = {};
  Map concat = {};

  void perdeu() {
    print('indo pra tela de derrota');
    Navigator.pushReplacementNamed(context, '/derrota', arguments: concat);
  }

  void ganhou() {
    print('indo pra tela de vitória');
    Navigator.pushReplacementNamed(context, '/vitoria', arguments: concat);
  }

  void encerrar(){
    dados['channel'].sink.add(json.encode({"function": "end", "code": lista.toString(), "username": dados['nome']}));
    dados['channel'].stream.listen((message){
      var result = json.decode(message);
      if (result['response'] == "ok"){
        print("(Jogo) -> Servidor recebeu meu codigo");
      }
      if (result['response'] == "fim"){
        Map pontosResult = {};
        if (result['status'] == "1"){
          pontosResult = {
            'pontosR': '1'
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          ganhou();
          dados['channel'].sink.close(status.goingAway);
        }
        if (result['status'] == "0"){
          pontosResult = {
            'pontosR': '1'
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          perdeu();
          dados['channel'].sink.close(status.goingAway);
        }
      }
    });
  }

  void manipulaCodigo(String text) {
    tedit.clear();
    setState(() {
      isComposing = false;
    });
    Code codigo = new Code(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      ),
    );
    setState(() {
      lcode.insert(0, codigo);      
    });
    codigo.animationController.forward();
  }

  void dispensar() {
    for(Code codigo in lcode){
      codigo.animationController.dispose();
    }
    super.dispose();
  }

  Widget buildTextComposer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: tedit,
              style: TextStyle(
                color: Colors.yellow,
              ),
              onChanged: (String text) {
                setState(() {
                  isComposing = text.length > 0;
                });
              },
              onSubmitted: manipulaCodigo,
              decoration: InputDecoration(
                hintText: 'Digite o código',
                hintStyle: TextStyle(
                  color: Colors.yellow,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.send),
              color: Colors.grey[500],
              onPressed: isComposing ? () => manipulaCodigo(tedit.text) : null,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: RaisedButton(
              child: Text(
                'Finalizar',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              color: Colors.grey[500],
              onPressed: () => {encerrar()},
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$bgImage'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    Color bgColor = Colors.black;

    dados = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: bgColor,
      
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => lcode[index],
                  itemCount: lcode.length,
                ),
              ),
              Divider(height: 1.0,),
              Container(
                child: buildTextComposer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Code extends StatelessWidget {

  Code({this.text, this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          margin: EdgeInsets.only(top: 2.0),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }
}
