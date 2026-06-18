import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import 'step_detail_screen.dart';

/// "Todos os caminhos" — espelha o fluxograma completo do projeto.
///
/// `embedded = true` quando é a aba inicial (perfil "quero ver tudo");
/// nesse caso não mostra AppBar própria.
class AllPathsScreen extends StatelessWidget {
  const AllPathsScreen({super.key, this.embedded = false});

  final bool embedded;

  // Cores por gravidade (mesma leitura do diagrama do projeto).
  static const _toneColor = {
    BranchTone.calm: Color(0xFF1F9D6B),
    BranchTone.attention: Color(0xFFC98A16),
    BranchTone.refer: Color(0xFFC0473B),
  };

  @override
  Widget build(BuildContext context) {
    final body = ListView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      children: [
        if (embedded) ...[
          const Text('Todos os caminhos',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
          const SizedBox(height: 8),
        ],
        const Text(
          'O resultado do preventivo abre três caminhos. Toque para entender cada etapa.',
          style: TextStyle(fontSize: 15, color: AppColors.textMuted, height: 1.5),
        ),
        const SizedBox(height: 20),
        ...allPaths.map((p) => _PathCard(branch: p, color: _toneColor[p.tone]!)),
        const SizedBox(height: 12),
        const _Label('QUANDO O EXAME É O TESTE DE HPV'),
        const SizedBox(height: 12),
        ...hpvPaths.map((h) => _HpvCard(path: h, color: _toneColor[h.tone]!)),
      ],
    );

    if (embedded) return body;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Todos os caminhos', style: TextStyle(fontSize: 16)),
      ),
      body: SafeArea(child: body),
    );
  }
}

class _PathCard extends StatelessWidget {
  const _PathCard({required this.branch, required this.color});
  final PathBranch branch;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(left: BorderSide(color: color, width: 5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(branch.label,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
          const SizedBox(height: 2),
          Text('No laudo: ${branch.code}',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: color)),
          const SizedBox(height: 8),
          Text(branch.summary,
              style: const TextStyle(
                  fontSize: 14, height: 1.5, color: AppColors.textMuted)),
          const SizedBox(height: 12),
          // Etapas deste caminho (chips clicáveis)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: branch.stepIds.map((id) {
              final c = stepContents[id]!;
              return ActionChip(
                label: Text(c.title,
                    style: const TextStyle(fontSize: 12.5)),
                backgroundColor: AppColors.surfaceSoft,
                side: BorderSide.none,
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StepDetailScreen(content: c),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _HpvCard extends StatelessWidget {
  const _HpvCard({required this.path, required this.color});
  final HpvPath path;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(path.label,
              style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 2),
          Text(path.conduct,
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textMuted));
  }
}
