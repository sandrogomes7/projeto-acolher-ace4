import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';

/// "Tira-dúvidas" — perguntas frequentes (expansíveis) + glossário.
class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        const Text('Tira-dúvidas',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: 8),
        const Text('Toque numa pergunta para ver a resposta.',
            style: TextStyle(fontSize: 15, color: AppColors.textMuted)),
        const SizedBox(height: 24),
        const _SectionLabel('PERGUNTAS FREQUENTES'),
        const SizedBox(height: 12),
        ...faqItems.map((f) => _FaqTile(item: f)),
        const SizedBox(height: 24),
        const _SectionLabel('PALAVRAS DIFÍCEIS'),
        const SizedBox(height: 12),
        ...glossary.map((g) => _GlossaryTile(item: g)),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
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

class _FaqTile extends StatelessWidget {
  const _FaqTile({required this.item});
  final FaqItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.primary,
          title: Text(item.question,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(item.answer,
                  style: const TextStyle(
                      fontSize: 14, height: 1.5, color: AppColors.textMuted)),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlossaryTile extends StatelessWidget {
  const _GlossaryTile({required this.item});
  final GlossaryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.term,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark)),
          const SizedBox(height: 4),
          Text(item.meaning,
              style: const TextStyle(fontSize: 14, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
