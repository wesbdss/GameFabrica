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
  int line = 0;
  String lista;
  final List<Code> lcode = <Code>[];
  final TextEditingController tedit = new TextEditingController();
  bool isComposing = false;
  Map dados = {};
  Map concat = {};

  void perdeu(Map m) {
    print('indo pra tela de derrota');
    Navigator.pushReplacementNamed(context, '/derrota', arguments: m);
  }

  void ganhou(Map m) {
    print('indo pra tela de vitória');
    Navigator.pushReplacementNamed(context, '/vitoria', arguments: m);
  }

  void encerrar(){
    print("Dados pontos");
    print(dados['pontos']);
    dados['channel'].sink.add(json.encode({"function": "end", "username": dados['nome']}));
    dados['channel'].stream.listen((message){
      var result = json.decode(message);
      if (result['response'] == "ok"){
        print("(Jogo) -> Servidor recebeu meu codigo");
      }
      if (result['response'] == "fim"){
        Map pontosResult = {};
        print("result pontos");
        print(result['pontos']);
        if (result['status'] == "1"){
          pontosResult = {
            'pontosR': result['pontos']
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          ganhou(concat);
          dados['channel'].sink.close(status.goingAway);
        }
        if (result['status'] == "0"){
          pontosResult = {
            'pontosR': result['pontos']
          };
          concat = {}..addAll(dados)..addAll(pontosResult);
          perdeu(concat);
          dados['channel'].sink.close(status.goingAway);
        }
      }
    });
  }

  void manipulaCodigo(String text) {
    dados['channel'].sink.add(json.encode({"function":"ingame","input":"$text","line":"$line","username":"${dados['nome']}"}));
    setState(() {
      isComposing = false;
      line+=1;
    });
    tedit.clear();
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

  void dica() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(
            "Dica!!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: <Widget>[
              new Text(
                "Crie um programa que mostre os 5 primeiros números primos",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              Text(
                'Use a função print.',
              ),
              Text(
                'Os 5 primeiros primos são 2,3,5,7,11'
              ),
            ],
          ),
          actions: <Widget>[
            // define os botões na base do dialogo
            new FlatButton(
              child: new Text("Fechar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: Icon(Icons.info_outline),
              color: Colors.grey[500],
              onPressed: () => {dica()},
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
