import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loggedIn = false;
  String _userName = 'Colaborador GudanBridge';

  // Dados fake para demonstração
  final double _bemEstarGeral = 0.78;
  final double _humor = 0.82;
  final double _energia = 0.70;
  final double _equilibrio = 0.65;
  final double _crescimento = 0.88;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Para demo, qualquer email/senha funciona
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha e-mail e senha para continuar.'),
        ),
      );
      return;
    }

    setState(() {
      _loggedIn = true;
      _userName = _emailController.text.split('@').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seu perfil de bem-estar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loggedIn ? _buildProfileView() : _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vamos personalizar sua experiência?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Faça um cadastro simples para visualizar o seu progresso de bem-estar no trabalho.',
        ),
        const SizedBox(height: 24),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-mail corporativo',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Senha',
            border: OutlineInputBorder(),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _login,
            child: const Text('Entrar e ver meu progresso'),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Obs.: Esta é uma versão demonstrativa. Os dados apresentados são exemplos para a apresentação.',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildProfileView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Olá, $_userName 👋',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Aqui está um resumo do seu bem-estar e desenvolvimento dentro do trabalho.',
          ),
          const SizedBox(height: 24),

          // "Roda" de desempenho (versão visual com círculo + indicadores)
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CircularProgressIndicator(
                      value: _bemEstarGeral,
                      strokeWidth: 14,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Bem-estar geral',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${(_bemEstarGeral * 100).round()}%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Dimensões do seu perfil',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildDimensionRow('Humor', _humor,
              'Seu humor tem se mantido em um bom nível na maior parte dos dias.'),
          const SizedBox(height: 8),
          _buildDimensionRow('Energia', _energia,
              'Sua energia oscila um pouco. Pausas conscientes podem ajudar.'),
          const SizedBox(height: 8),
          _buildDimensionRow('Equilíbrio vida-trabalho', _equilibrio,
              'Ainda há espaço para ajustar limites e horários de descanso.'),
          const SizedBox(height: 8),
          _buildDimensionRow('Crescimento profissional', _crescimento,
              'Você está avançando bem nas suas metas de desenvolvimento.'),

          const SizedBox(height: 24),
          const Text(
            'Resumo em palavras',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'De forma geral, você está construindo um perfil saudável e em evolução. '
                'Continue registrando seus dias, praticando micro-hábitos e ajustando suas metas. '
                'Lembre-se: bem-estar sustentável é uma jornada, não uma linha de chegada.',
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionRow(String title, double value, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 120,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
              ),
            ),
            const SizedBox(width: 8),
            Text('${(value * 100).round()}%'),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
