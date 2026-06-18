import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import 'all_paths_screen.dart';
import 'step_detail_screen.dart';

/// "Minha jornada" — mostra SÓ o caminho da paciente (definido no onboarding).
class JourneyScreen extends StatelessWidget {
  const JourneyScreen({super.key, required this.plan, this.onChangeSituation});

  final JourneyPlan plan;
  final VoidCallback? onChangeSituation;

  void _openStep(BuildContext context, PlannedStep step, int number, int total) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StepDetailScreen(
          content: step.content,
          statusLabel: step.statusLabel,
          stepNumber: number,
          totalSteps: total,
          breadcrumbLabel: 'Minha jornada',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (plan.exploreAll) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Todos os caminhos',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark)),
                ),
                _ChangeButton(onTap: onChangeSituation),
              ],
            ),
          ),
          const Expanded(child: AllPathsScreen(embedded: true)),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text('Minha jornada',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark)),
            ),
            _ChangeButton(onTap: onChangeSituation),
          ],
        ),
        const SizedBox(height: 6),
        Text(plan.headline,
            style: const TextStyle(fontSize: 15, color: AppColors.textMuted)),
        const SizedBox(height: 24),
        ...List.generate(plan.steps.length, (i) {
          return _TimelineTile(
            step: plan.steps[i],
            isLast: i == plan.steps.length - 1,
            onOpen: () =>
                _openStep(context, plan.steps[i], i + 1, plan.steps.length),
          );
        }),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AllPathsScreen()),
          ),
          icon: const Icon(Icons.account_tree_rounded,
              color: AppColors.primary, size: 20),
          label: const Text('Ver todos os caminhos',
              style: TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w600)),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            minimumSize: const Size(double.infinity, 0),
            side: const BorderSide(color: AppColors.border, width: 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
      ],
    );
  }
}

class _ChangeButton extends StatelessWidget {
  const _ChangeButton({this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (onTap == null) return const SizedBox.shrink();
    return TextButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.edit_rounded, size: 16, color: AppColors.primary),
      label: const Text('Mudar',
          style:
              TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        backgroundColor: AppColors.surfaceSoft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.step,
    required this.isLast,
    required this.onOpen,
  });

  final PlannedStep step;
  final bool isLast;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final isCurrent = step.status == StepStatus.current;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Linha do tempo (bolinha + traço)
          Column(
            children: [
              _TimelineDot(status: step.status),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: AppColors.border),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: isCurrent
                  ? _CurrentCard(step: step, onOpen: onOpen)
                  : _PlainRow(step: step, onOpen: onOpen),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot({required this.status});
  final StepStatus status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepStatus.done:
        return Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
              color: AppColors.primary, shape: BoxShape.circle),
          child: const Icon(Icons.check_rounded,
              size: 16, color: AppColors.white),
        );
      case StepStatus.current:
        // anel verde com centro branco
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary, width: 4),
          ),
        );
      default:
        return Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border, width: 2),
          ),
        );
    }
  }
}

/// Linha simples (etapas concluídas ou futuras) — sem caixa.
class _PlainRow extends StatelessWidget {
  const _PlainRow({required this.step, required this.onOpen});
  final PlannedStep step;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final isFuture =
        step.status == StepStatus.next || step.status == StepStatus.later;
    final titleColor = isFuture ? AppColors.textMuted : AppColors.textDark;
    return InkWell(
      onTap: onOpen,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.content.title,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: titleColor)),
                  const SizedBox(height: 2),
                  Text(step.statusLabel,
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textMuted.withOpacity(
                              isFuture ? 0.8 : 1))),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded,
                color: AppColors.textMuted.withOpacity(isFuture ? 0.6 : 1)),
          ],
        ),
      ),
    );
  }
}

/// Card destacado da etapa atual ("Você está aqui").
class _CurrentCard extends StatelessWidget {
  const _CurrentCard({required this.step, required this.onOpen});
  final PlannedStep step;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('VOCÊ ESTÁ AQUI',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3)),
          ),
          const SizedBox(height: 10),
          Text(step.content.title,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark)),
          const SizedBox(height: 6),
          Text(step.content.summary,
              style: const TextStyle(
                  fontSize: 14, height: 1.45, color: AppColors.textDark)),
          const SizedBox(height: 14),
          // Botão "Entender esta etapa →"
          Material(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onOpen,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Entender esta etapa',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded,
                        color: AppColors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
