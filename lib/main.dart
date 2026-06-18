import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/welcome_carousel_screen.dart';

void main() {
  runApp(const AcolherApp());
}

class AcolherApp extends StatelessWidget {
  const AcolherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acolher',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const WelcomeCarouselScreen(),
    );
  }
}
