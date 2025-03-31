# Teste de Conhecimento

Um aplicativo de quiz desenvolvido com Flutter, focado em testar conhecimentos em diferentes áreas.

## Características

- Interface moderna e intuitiva
- Animações suaves
- Sistema de pontuação
- Modo escuro/claro
- Perfil de usuário personalizado
- Banco de dados local para questões
- Design responsivo

## Tecnologias Utilizadas

- Flutter 3.7+
- Dart 3.0+
- SQLite para persistência local
- BLoC para gerenciamento de estado
- Provider para injeção de dependências
- Shared Preferences para configurações
- Flutter Animate para animações

## Estrutura do Projeto

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   └── theme/
│       └── app_theme.dart
└── features/
    └── quiz/
        ├── data/
        │   ├── models/
        │   │   └── question_model.dart
        │   └── repositories/
        │       ├── quiz_repository.dart
        │       └── quiz_data.dart
        └── presentation/
            ├── bloc/
            │   ├── quiz_bloc.dart
            │   ├── quiz_event.dart
            │   └── quiz_state.dart
            ├── pages/
            │   ├── menu_page.dart
            │   ├── quiz_page.dart
            │   └── settings_page.dart
            └── widgets/
                ├── question_card.dart
                └── result_card.dart
```

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/z3nr1q/teste_conhecimento.git
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Execute o aplicativo:
```bash
flutter run
```

## Desenvolvimento

O projeto segue uma arquitetura limpa com separação de responsabilidades:

- **Core**: Contém código compartilhado, constantes e temas
- **Features**: Módulos do aplicativo organizados por funcionalidade
- **Data**: Camada de dados com modelos e repositórios
- **Presentation**: Interface do usuário com BLoC, páginas e widgets

## Contribuição

1. Fork o projeto
2. Crie sua Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a Branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo LICENSE para detalhes.
