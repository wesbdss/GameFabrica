import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

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
  Future<void> getInfo() async {
    // Vai tentar conectar com o servidor 
    try {           
      cont();
      // Valores que o servidor vai retornar, por hora ficticios
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
      channel = IOWebSocketChannel.connect('ws://localhost:8080');
    }catch (e){
      print(e);
    }
  
  }
}