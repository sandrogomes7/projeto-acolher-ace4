import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import 'journey_screen.dart';
import 'faq_screen.dart';
import 'onboarding_screen.dart';
import 'support_screen.dart';

/// Casca com a barra inferior: Jornada · Dúvidas · Apoio.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.plan});

  final JourneyPlan plan;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  late JourneyPlan _plan = widget.plan;

  /// Reabre a tela "Onde você está agora?" e remonta o caminho.
  Future<void> _changeSituation() async {
    final index = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (_) => const OnboardingScreen(asPicker: true)),
    );
    if (index != null) {
      setState(() => _plan = journeyForOnboarding(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      JourneyScreen(plan: _plan, onChangeSituation: _changeSituation),
      const FaqScreen(),
      const SupportScreen(),
    ];

    return Scaffold(
      body: SafeArea(bottom: false, child: pages[_index]),
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.bgSurface,
          border: Border(
            top: BorderSide(color: AppColors.borderWarm, width: 1),
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: AppColors.bgSurface,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            elevation: 0,
            height: 84,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              final color = states.contains(WidgetState.selected)
                  ? AppColors.primaryPlum
                  : AppColors.textMutedWarm;
              return IconThemeData(color: color, size: 24);
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final selected = states.contains(WidgetState.selected);
              return TextStyle(
                color:
                    selected ? AppColors.primaryPlum : AppColors.textMutedWarm,
                fontSize: 11,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.timeline_rounded),
                label: 'Jornada',
              ),
              NavigationDestination(
                icon: Icon(Icons.help_outline_rounded),
                label: 'Dúvidas',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline_rounded),
                label: 'Apoio',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
