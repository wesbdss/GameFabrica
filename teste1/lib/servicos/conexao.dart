class Conexao {

  /*
    credencial vai ser true se o nome e a senha forem válidos, false se for o contrário.
  */
  String nome, senha, situacao;
  int vitoria, derrota, pontos;
  double ratio;
  bool credencial;

  Conexao();

  // função só pra dar um tempo pra fingir q ta conectando
  void cont() {
    for(int i = 0; i < 250; i++){
      print(i+1);
    }
  }

  // Função que vai buscar um inimigo e suas informações
  Future<void> getInfoInimigo() async {
    try {           
      cont();
      // Valores que o servidor vai retornar, por hora ficticios
      nome = 'allan2';
      senha = 'allan2';
      vitoria = 2;
      derrota = 1;
      pontos = 10;
      ratio = 2.0;
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
}
