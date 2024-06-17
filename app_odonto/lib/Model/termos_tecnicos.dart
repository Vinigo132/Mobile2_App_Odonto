

class TermosTecnicos{

  final String nome;
  final String descricao;
  final bool status;

  TermosTecnicos(this.nome, this.descricao, this.status);

  //Transforma um OBJETO em JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'nome': nome,
      'descricao': descricao,
      'status': status
    };
  }

  //Transforma um JSON em OBJETO
  factory TermosTecnicos.fromJson(Map<String, dynamic> json) {
    return TermosTecnicos(
      json['nome'],
      json['descricao'],
      json['status'],
    );
  }

}

