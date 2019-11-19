import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      },);    
    });
    dados['channel'].close();
  }
  
  void login(bool x) async {
    Conexao instance = Conexao();
    dados['credencial'] = x;
    if(x) {
      print('login succesful');
      await instance.getInfo(dados['channel']);
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

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);

    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    String bgImage = 'login.png';
    Color bgColor = Colors.black;

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
                SizedBox(height: 175.0),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    hintText: 'Usuário',
                    hintStyle: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  autocorrect: false,
                  onChanged: (String valor) {inputUser(valor);},
                ),
                SizedBox(height: 50.0),
                TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    hintText: 'Senha',
                    hintStyle: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                  obscureText: true,
                  onChanged: (String valor) {inputPassword(valor);},
                ),
                SizedBox(height: 50.0),
                GestureDetector(
                  child: Container(
                    width:120,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image:AssetImage("assets/entrar.png"), 
                        fit:BoxFit.cover
                      ),
                    ),
                  ),onTap:(){
                    checkCredential();
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
