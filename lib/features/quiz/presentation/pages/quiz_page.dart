import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/question_model.dart';
import '../../data/repositories/quiz_repository.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  List<QuestionModel> _questions = [];
  int? _selectedOption;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final repository = Provider.of<QuizRepository>(context, listen: false);
    final questions = await repository.getAllQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void _selectOption(int index) {
    if (_showResult) return;
    setState(() {
      _selectedOption = index;
    });
  }

  void _checkAnswer() {
    setState(() {
      _showResult = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedOption = null;
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];
    final isLastQuestion = _currentQuestionIndex == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Informações adicionais da questão
            if (question.banca != null || question.ano != null || 
                question.edital != null || question.instituicao != null ||
                question.tipoInstituicao != null || question.nivelInstituicao != null ||
                question.cargo != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (question.banca != null)
                        Text('Banca: ${question.banca}'),
                      if (question.ano != null)
                        Text('Ano: ${question.ano}'),
                      if (question.edital != null)
                        Text('Edital: ${question.edital}'),
                      if (question.nivel != null)
                        Text('Nível: ${question.nivel}'),
                      if (question.instituicao != null)
                        Text('Instituição: ${question.instituicao}'),
                      if (question.tipoInstituicao != null)
                        Text('Tipo de Instituição: ${question.tipoInstituicao}'),
                      if (question.nivelInstituicao != null)
                        Text('Nível da Instituição: ${question.nivelInstituicao}'),
                      if (question.cargo != null)
                        Text('Cargo: ${question.cargo}'),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Questão
            Text(
              'Questão ${_currentQuestionIndex + 1}/${_questions.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              question.questao,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            // Opções
            ...List.generate(
              question.opcoes.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Material(
                  color: _getOptionColor(index, question),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () => _selectOption(index),
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            String.fromCharCode(65 + index),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(question.opcoes[index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Mensagem de questão anulada
            if (question.isAnulada && _showResult)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Questão anulada',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const Spacer(),
            // Botões
            if (!_showResult)
              ElevatedButton(
                onPressed: _selectedOption != null ? _checkAnswer : null,
                child: const Text('Verificar'),
              )
            else
              ElevatedButton(
                onPressed: !isLastQuestion ? _nextQuestion : null,
                child: Text(isLastQuestion ? 'Finalizar' : 'Próxima'),
              ),
          ],
        ),
      ),
    );
  }

  Color _getOptionColor(int index, QuestionModel question) {
    if (!_showResult) {
      return _selectedOption == index
          ? Colors.blue.withOpacity(0.2)
          : Colors.grey.withOpacity(0.1);
    }

    if (question.isAnulada) {
      return Colors.orange.withOpacity(0.1);
    }

    if (index == question.indiceOpcaoCorreta) {
      return Colors.green.withOpacity(0.2);
    }

    if (index == _selectedOption) {
      return Colors.red.withOpacity(0.2);
    }

    return Colors.grey.withOpacity(0.1);
  }
}
