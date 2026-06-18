import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import 'home_shell.dart';

/// Tela "Onde você está agora?" — define o caminho da jornada.
///
/// Usada em dois modos:
///  - 1ª vez (asPicker = false): ao escolher, entra no app (HomeShell).
///  - Para mudar depois (asPicker = true): ao escolher, devolve o índice
///    com Navigator.pop(index) para a Jornada remontar o caminho.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key, this.asPicker = false});

  final bool asPicker;

  void _enter(BuildContext context, int index) {
    if (asPicker) {
      Navigator.of(context).pop(index);
      return;
    }
    final plan = journeyForOnboarding(index);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomeShell(plan: plan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: asPicker
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text('Mudar minha situação',
                  style: TextStyle(fontSize: 16)),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const Text(onboardingTitle,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  )),
              const SizedBox(height: 12),
              const Text(onboardingSubtitle,
                  style: TextStyle(
                      fontSize: 15, color: AppColors.textMuted, height: 1.5)),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: onboardingOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) => _OptionCard(
                    label: onboardingOptions[i],
                    icon: onboardingIcons[i],
                    onTap: () => _enter(context, i),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard(
      {required this.label, required this.icon, required this.onTap});
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.surfaceSoft,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primary, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(label,
                    style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w500)),
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}
