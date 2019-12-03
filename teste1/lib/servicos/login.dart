import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teste1/servicos/conexao.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username = '', password = '';
  Map dados = {};
  var entrou = 0;

  MediaQueryData queryData;

  void checkCredential() async {
    print('User: $username, Senha: $password');
    final response = await http.post("http://lit-fortress-57323.herokuapp.com/",
    headers: {"Content-type": "application/json"},
    body: json.encode({"function": "login","username":"$username","pass":"$password"}));
    final responseJson = json.decode(response.body);
    print(responseJson['response'].toString());
    print(responseJson);
    //dados['credencial'] = false;
    if ((responseJson.toString()) == '{response: True}'){
      print("entrou");
      entrou = 1;
    }
    login();
  }
  
    /*
    User: wey, Senha: wey
    True
    {response: True}
    Unhandled Exception: type 'bool' is not a subtype of type 'String' of 'value'
    */

  void login() async {
    Conexao instance = Conexao();
    //print("LOGIN");
    if(entrou == 1) {
      print('login successful');
      await instance.getInfo(username);
      dados = {
        'nome': instance.nome,
        'vitoria': instance.vitoria,
        'derrota': instance.derrota,
        'pontos': instance.pontos,
      };
      Navigator.pushReplacementNamed(context, '/home', arguments: dados);
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

  void sobre() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: new Text(
            "Sobre",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: new Text(
            "Trabalho de Fábrica de Software 2019/2 Alunos: Allan Leite, Emily Safira e Wesley Benicio 01/12/19",
            style: TextStyle(
              fontSize: 14.0,
            ),
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
                SizedBox(height: 60.0),
                FlatButton(
                  child: Text(
                    'Sobre',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                  onPressed: () => {sobre()},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
