import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/quiz_repository.dart';
import '../bloc/quiz_bloc.dart';
import 'quiz_page.dart';
import 'settings_page.dart';
import 'import_questions_page.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste de Conhecimento'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppConstants.appName,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ).animate()
                  .fadeIn()
                  .scale(),
                const SizedBox(height: 48),
                _MenuButton(
                  icon: Icons.play_arrow,
                  label: 'Iniciar Quiz',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => QuizBloc(
                          repository: context.read<QuizRepository>(),
                        ),
                        child: const QuizPage(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.file_upload,
                  label: 'Importar Questões',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ImportQuestionsPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.settings,
                  label: 'Configurações',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _MenuButton(
                  icon: Icons.info,
                  label: 'Sobre',
                  onTap: () {
                    // TODO: Implementar tela sobre
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ).animate()
      .fadeIn()
      .slideX(begin: 0.3, end: 0);
  }
}
