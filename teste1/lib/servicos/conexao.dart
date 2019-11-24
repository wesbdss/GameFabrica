import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

//import 'package:web_socket_channel/status.dart' as status;
//import 'package:web_socket_channel/web_socket_channel.dart';

class Conexao {

  /*
    credencial vai ser true se o nome e a senha forem válidos, false se for o contrário.
  */
  String nome, senha, situacao;
  var vitoria, derrota, pontos;
  bool credencial;

  List<String> nomesOp;
  List<int> pontosOp, vitoriasOp, derrotasOp;

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
      // final response = await http.post("http://192.168.0.102:8080/",
      // headers: {"Content-type": "application/json"},
      // body: json.encode({"function": "getInfo"}));
      // final responseJson = json.decode(response.body);

      // Valores que o servidor vai retornar
      // print("Pegou os valores: ${responseJson['nomesOp']}");
      // nomesOp = responseJson['nomesOp'];
      // vitoriasOp = responseJson['vitoriasOp'];
      // derrotasOp = responseJson['derrotasOp'];
      // pontosOp = responseJson['pontosOp'];

      nomesOp = ['a'];
      vitoriasOp = [1];
      derrotasOp = [0];
      pontosOp = [45];
    }
    catch (e) {
      //Se não conseguir conectar vai imprimir um erro pro user
      print(e);
      situacao = 'Não foi possível se conectar com os nossos serviços\ntente reiniciar a aplicação!';
    }
  }

  // Função que vai retornar as informações da pessoa
  Future<void> getInfo(String username) async {
    // Vai tentar conectar com o servidor
    try {           
      cont();
      
      final response = await http.post("http://192.168.0.102:8080/",
      headers: {"Content-type": "application/json"},
      body: json.encode({"function": "getInfo","username":"$username"}));
      final responseJson = json.decode(response.body);
      //print(responseJson['response']);

      // Valores que o servidor vai retornar
      print("Pegou os valores: ${responseJson['vitoria']}");
      nome = username;
      vitoria = responseJson['vitoria'];
      derrota = responseJson['derrota'];
      pontos = responseJson['pontos'];
    }
    catch (e) {
      //Se não conseguir conectar vai imprimir um erro pro user
      print(e);
      situacao = 'Não foi possível se conectar com os nossos serviços\ntente reiniciar a aplicação!';
    }
  }

  Future<void> roleplay() async {
    cont();
    print('conectado');
  }

  Future<void> enviando(String msg) async {

  }
  // Future<void> connect() async{
  //   try{
  //     channel = IOWebSocketChannel.connect('ws://192.168.0.102:8080');
  //   }catch(e){
  //     print(e);
  //   }
  // }
}
