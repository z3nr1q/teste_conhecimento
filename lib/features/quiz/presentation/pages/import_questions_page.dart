import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/quiz_repository.dart';
import '../../data/services/question_import_service.dart';

class ImportQuestionsPage extends StatefulWidget {
  const ImportQuestionsPage({super.key});

  @override
  State<ImportQuestionsPage> createState() => _ImportQuestionsPageState();
}

class _ImportQuestionsPageState extends State<ImportQuestionsPage> {
  bool _isLoading = false;
  String? _error;
  String? _success;

  Future<void> _importQuestions() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      setState(() {
        _isLoading = true;
        _error = null;
        _success = null;
      });

      try {
        final repository = context.read<QuizRepository>();
        final importService = QuestionImportService(repository: repository);
        final questions = await importService.importFromJson(result.files.first.path!);

        setState(() {
          _success = 'Importadas ${questions.length} questões com sucesso!';
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
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
              'Selecione um arquivo JSON com questões para importar.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'O arquivo deve seguir o formato especificado em assets/data/question_format.json',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _importQuestions,
              icon: const Icon(Icons.upload_file),
              label: const Text('Selecionar Arquivo JSON'),
            ),
            const SizedBox(height: 24),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_error != null)
              Card(
                color: Colors.red.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _error!,
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              ),
            if (_success != null)
              Card(
                color: Colors.green.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    _success!,
                    style: TextStyle(color: Colors.green.shade900),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
