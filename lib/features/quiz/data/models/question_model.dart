import 'dart:convert';

class QuestionModel {
  final int id;
  final String questao;
  final List<String> opcoes;
  final int? indiceOpcaoCorreta; // Pode ser nulo para questões anuladas
  final String assunto;
  final int dificuldade;
  
  // Campos opcionais
  final String? banca;
  final int? ano;
  final String? edital;
  final String? nivel;

  bool get isAnulada => indiceOpcaoCorreta == null;

  QuestionModel({
    required this.id,
    required this.questao,
    required this.opcoes,
    this.indiceOpcaoCorreta, // Agora é opcional
    required this.assunto,
    required this.dificuldade,
    this.banca,
    this.ano,
    this.edital,
    this.nivel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questao': questao,
      'opcoes': jsonEncode(opcoes),
      'indiceOpcaoCorreta': indiceOpcaoCorreta,
      'assunto': assunto,
      'dificuldade': dificuldade,
      'banca': banca,
      'ano': ano,
      'edital': edital,
      'nivel': nivel,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      questao: map['questao'] as String,
      opcoes: List<String>.from(
        map['opcoes'] is String 
          ? jsonDecode(map['opcoes'])
          : map['opcoes'],
      ),
      indiceOpcaoCorreta: map['indiceOpcaoCorreta'] as int?,
      assunto: map['assunto'] as String,
      dificuldade: map['dificuldade'] as int,
      banca: map['banca'] as String?,
      ano: map['ano'] as int?,
      edital: map['edital'] as String?,
      nivel: map['nivel'] as String?,
    );
  }

  factory QuestionModel.fromJson(String source) => 
      QuestionModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'QuestionModel(id: $id, questao: $questao, opcoes: $opcoes, indiceOpcaoCorreta: $indiceOpcaoCorreta, assunto: $assunto, dificuldade: $dificuldade)';
  }
}
