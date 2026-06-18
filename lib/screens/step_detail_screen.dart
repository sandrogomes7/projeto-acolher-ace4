import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/audio_button.dart';
import '../widgets/primary_button.dart';

/// Tela de detalhe de uma etapa (nó do fluxograma), com áudio.
/// Layout fiel ao Figma "Etapa aberta".
class StepDetailScreen extends StatelessWidget {
  const StepDetailScreen({
    super.key,
    required this.content,
    this.statusLabel = '',
    this.stepNumber,
    this.totalSteps,
    this.breadcrumbLabel = 'Voltar',
  });

  final StepContent content;
  final String statusLabel;
  final int? stepNumber;
  final int? totalSteps;
  final String breadcrumbLabel;

  @override
  Widget build(BuildContext context) {
    final showProgress = stepNumber != null && totalSteps != null;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            // Breadcrumb verde "← Minha jornada"
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back_rounded,
                        size: 20, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(breadcrumbLabel,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(content.title,
                style: const TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark)),
            const SizedBox(height: 16),
            if (showProgress) ...[
              Row(
                children: List.generate(totalSteps!, (i) {
                  final active = i < stepNumber!;
                  return Expanded(
                    child: Container(
                      height: 6,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: active ? AppColors.primary : AppColors.border,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(statusLabel,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary)),
                  Text('Etapa $stepNumber de $totalSteps',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
              const SizedBox(height: 18),
            ],
            // Acolhimento (card ROSA)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.pinkSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      color: AppColors.pinkText, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(content.reassurance,
                        style: const TextStyle(
                            fontSize: 15,
                            height: 1.3,
                            color: AppColors.pinkText,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            // Seções (label verde com ícone + divisória bege)
            for (int i = 0; i < content.sections.length; i++) ...[
              _Section(section: content.sections[i]),
              if (i < content.sections.length - 1) ...[
                const SizedBox(height: 18),
                Container(height: 1, color: AppColors.border),
                const SizedBox(height: 18),
              ],
            ],
            const SizedBox(height: 22),
            // Dica (card verde claro)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.description_outlined,
                      color: AppColors.brandDark, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(content.tip,
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.35,
                            color: AppColors.brandDark,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AudioButton(audioFile: content.audio),
            const SizedBox(height: 12),
            // Botão verde "Voltar para minha jornada"
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Voltar para minha jornada',
                icon: null,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.section});
  final StepSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.info_outline_rounded,
                size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(section.label.toUpperCase(),
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.4,
                      color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(section.text,
            style: const TextStyle(
                fontSize: 16, height: 1.5, color: AppColors.textDark)),
      ],
    );
  }
}
