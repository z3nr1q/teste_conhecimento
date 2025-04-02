import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/services/question_import_service.dart';

class ImportQuestionsPage extends StatefulWidget {
  const ImportQuestionsPage({super.key});

  @override
  State<ImportQuestionsPage> createState() => _ImportQuestionsPageState();
}

class _ImportQuestionsPageState extends State<ImportQuestionsPage> {
  final _textController = TextEditingController();
  String _message = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _importQuestions() async {
    if (_textController.text.isEmpty) {
      setState(() {
        _message = 'Por favor, cole o JSON das questões';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = 'Importando questões...';
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final repository = QuizRepository(prefs);
      final service = QuestionImportService(repository);
      
      final importedCount = await service.importQuestionsFromJson(_textController.text);
      
      setState(() {
        _message = 'Importadas $importedCount questões com sucesso!';
        _textController.clear();
      });
    } catch (e) {
      setState(() {
        _message = 'Erro ao importar questões: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar Questões'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cole aqui o JSON com as questões:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Cole o JSON aqui...',
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _message,
                  style: TextStyle(
                    color: _message.contains('Erro')
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: _isLoading ? null : _importQuestions,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Importar Questões'),
            ),
          ],
        ),
      ),
    );
  }
}
