import 'package:flutter/material.dart';
import 'package:teste1/servicos/conexao.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  String credencial = 'false';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username = '', password = '';
  Map dados = {};

  void checkCredential() async { 
    print('User: $username, Senha: $password');
    var encode = json.encode({"function":"login","username":"$username","pass":"$password"});
    dados['channel'].sink.add(encode);
    dados['channel'].stream.listen((message) {
      var result = json.decode(message);
      print(result);
      setState(() {
        if (result['response'] == 'true'){
          dados['credencial']= 'true';
          widget.credencial = 'true';
          login(true);
          return;
        } else {
          dados['credencial']= 'false';
          widget.credencial = 'false';
          login(false);
          return;      
        }
      });
    });
  }
  
  void login(bool x) async {
    Conexao instance = Conexao();
    dados['credencial'] = x;
    //print("3: ${dados['credencial']}");
    if(x) {
      print('login succesful');
      await instance.getInfo();
      Map dados2 = {
        'nome': instance.nome,
        'vitoria': instance.vitoria,
        'derrota': instance.derrota,
        'ratio': instance.ratio,
        'pontos': instance.pontos,
        'credencial': instance.credencial,
      };
      Map concat = {}..addAll(dados2)..addAll(dados);
      Navigator.pushReplacementNamed(context, '/home', arguments: concat);
    } else {
      print('login fail');
    }
  }

  void inputUser(String valor) {
    setState(() {
      username = valor;
    });
  }

  void inputPassword(String valor) {
    setState(() {
      password = valor;
    });
  }

  @override
  Widget build(BuildContext context) {

    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    // var encode = json.encode({"comi":"sua mae"});
    // print(dados['channel'].sink.add(encode));
    // dados['channel'].stream.listen((message) {
    //   var decode = json.decode(message);
    //   print(decode['response']);
    // });

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
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(height: 50.0),
                Text(
                  'Username: ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(width: 10.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  autocorrect: false,
                  onChanged: (String valor) {inputUser(valor);},
                ),
                SizedBox(height: 50.0),
                Text(
                  'Senha: ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                SizedBox(width: 50.0),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  obscureText: true,
                  onChanged: (String valor) {inputPassword(valor);},
                ),
                RaisedButton(
                  child: Text('Logar'),
                  onPressed: () {checkCredential();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
