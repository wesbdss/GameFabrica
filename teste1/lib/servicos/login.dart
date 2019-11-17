import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String username = '', password = '';
  Map dados = {};

  void checkCredential() {
    print('User: $username, Senha: $password');
    if (username == '' && password == '') {
      dados['credencial'] = true;
    } else {
      dados['credencial'] = false;
    }
  }

  void login() {
    checkCredential();
    if(dados['credencial'] == true) {
      print('login succesful');
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

  @override
  Widget build(BuildContext context) {

    dados = dados.isNotEmpty ? dados : ModalRoute.of(context).settings.arguments;

    String bgImage = 'fundo.jpg';
    Color bgColor = Colors.black;

    print(dados['channel']);

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
                  onPressed: () {login();},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}