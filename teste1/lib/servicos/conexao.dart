import 'dart:convert';

import 'package:http/http.dart' as http;


import 'package:web_socket_channel/io.dart';
//import 'package:web_socket_channel/status.dart' as status;
//import 'package:web_socket_channel/web_socket_channel.dart';

class Conexao {

  /*
    credencial vai ser true se o nome e a senha forem válidos, false se for o contrário.
  */
  var channel;
  String nome, senha, situacao;
  int vitoria, derrota, pontos;
  double ratio;
  bool credencial;

  Conexao();

  // função só pra dar um tempo pra fingir q ta conectando
  void cont() {
    int i;
    for(i = 0; i < 500; i++){      
    }
    print(i);
  }

  // Função que vai buscar um inimigo e suas informações
  Future<void> getInfoInimigo() async {
    try {           
      cont();
    }
    catch (e) {
      //Se não conseguir conectar vai imprimir um erro pro user
      print(e);
      situacao = 'Não foi possível se conectar com os nossos serviços\ntente reiniciar a aplicação!';
    }
  }

  // Função que vai retornar as informações da pessoa
  Future<void> getInfo(var channel) async {
    // Vai tentar conectar com o servidor
    try {           
      cont();
      // channel.stream.listen((message){
      //   var encode = json.encode({"function":"getinfo"});
      //   channel.sink.add(encode);
      //   var result = json.decode(message);
      //   nome = result['response']['username'];
      //   senha = result['response']['pass'];
      //   vitoria = result['response']['vitoria'];
      //   derrota = result['response']['derrota'];
      //   pontos = result['response']['pontos'];
      //   print('DENTRO!');
      //   print(nome);
      //   print(senha);
      //   print(vitoria);
      //   print(derrota);
      //   print(pontos);
      // });
      // print('FORA!');
      // print(nome);
      // print(senha);
      // print(vitoria);
      // print(derrota);
      // print(pontos);

      // Valores que o servidor vai retornar, por hora ficticios
      Future fetchPost() async {
          final response = await http.post("http://192.168.0.109:8080/",
          headers: {"Content-type": "application/json"},
          body: json.encode({"function": "login"}));
          final responseJson = json.decode(response.body);
          print(responseJson['response']);
      }
      nome = 'allan';
      senha = 'allan';
      vitoria = 1;
      derrota = 1;
      pontos = 10;
      ratio = 1.0;
    }
    catch (e) {
      //Se não conseguir conectar vai imprimir um erro pro user
      print(e);
      situacao = 'Não foi possível se conectar com os nossos serviços\ntente reiniciar a aplicação!';
    }
  }

  Future<void> connect() async{
    try{
      channel = IOWebSocketChannel.connect('ws://192.168.0.101:8080');
    }catch(e){
      print(e);
    }
  }
}
