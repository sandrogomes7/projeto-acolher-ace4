import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';

/// "Apoio" — mensagens de acolhimento e onde buscar ajuda.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        const Text('Apoio',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark)),
        const SizedBox(height: 8),
        const Text('Um espaço de cuidado com você.',
            style: TextStyle(fontSize: 15, color: AppColors.textMuted)),
        const SizedBox(height: 24),
        // Destaque
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      color: AppColors.brandDark, size: 26),
                  const SizedBox(width: 12),
                  Text(supportHighlightTitle,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark)),
                ],
              ),
              const SizedBox(height: 12),
              Text(supportHighlightBody,
                  style: const TextStyle(
                      fontSize: 15, height: 1.5, color: AppColors.textDark)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const _Label('MENSAGENS PARA VOCÊ'),
        const SizedBox(height: 12),
        ...supportMessages.map((m) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.spa_rounded,
                      color: AppColors.primary, size: 20),
                  const SizedBox(width: 12),
                  Text(m,
                      style: const TextStyle(
                          fontSize: 15, color: AppColors.textDark)),
                ],
              ),
            )),
        const SizedBox(height: 12),
        const _Label('ONDE BUSCAR AJUDA'),
        const SizedBox(height: 12),
        ...supportContacts.map((c) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border, width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(c.icon, color: AppColors.brandDark, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark)),
                        const SizedBox(height: 2),
                        Text(c.subtitle,
                            style: const TextStyle(
                                fontSize: 13, color: AppColors.textMuted)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
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
