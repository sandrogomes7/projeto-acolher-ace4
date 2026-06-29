import 'package:flutter/material.dart';

import 'data/content.dart';
import 'screens/home_shell.dart';
import 'theme/app_theme.dart';
import 'screens/welcome_carousel_screen.dart';
import 'services/journey_progress_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedCurrentStepIndex =
      await JourneyProgressStore.loadCurrentStepIndex();

  runApp(AcolherApp(savedCurrentStepIndex: savedCurrentStepIndex));
}

class AcolherApp extends StatelessWidget {
  const AcolherApp({super.key, this.savedCurrentStepIndex});

  final int? savedCurrentStepIndex;

  @override
  Widget build(BuildContext context) {
    final index = savedCurrentStepIndex;
    final hasSavedJourney =
        index != null && index >= 0 && index < onboardingOptions.length;

    return MaterialApp(
      title: 'Acolher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: hasSavedJourney
          ? HomeShell(currentStepIndex: index)
          : const WelcomeCarouselScreen(),
    );
  }
}
