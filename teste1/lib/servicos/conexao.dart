class Conexao {

  /*
    credencial vai ser true se o nome e a senha forem válidos, false se for o contrário.
  */
  String nome, senha, situacao;
  int vitoria, derrota, pontos;
  double ratio;
  bool credencial;

  Conexao();

  Future<void> getInfo() async {
    // Função que vai retornar as informações da pessoa

    try {
      //Vai tentar conectar com o servidor
    }
    catch (e) {
      //Se não conseguir conectar vai imprimir um erro pro user
      print(e);
      situacao = 'Não foi possível se conectar com os nossos serviços';
    }
  }
}
