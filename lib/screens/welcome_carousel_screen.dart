import 'package:flutter/material.dart';

import '../data/content.dart';
import '../theme/app_theme.dart';
import '../widgets/app_illustration.dart';
import '../widgets/audio_button.dart';
import '../widgets/primary_button.dart';
import 'onboarding_screen.dart';

/// Telas 0 a 5 do Figma — carrossel de boas-vindas com áudio.
class WelcomeCarouselScreen extends StatefulWidget {
  const WelcomeCarouselScreen({super.key});

  @override
  State<WelcomeCarouselScreen> createState() => _WelcomeCarouselScreenState();
}

class _WelcomeCarouselScreenState extends State<WelcomeCarouselScreen> {
  final _controller = PageController();
  int _index = 0;

  void _next() {
    if (_index < introPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      _goToApp();
    }
  }

  void _goToApp() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Topo: marca "Acolher" + pular
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Row(
                children: [
                  const Icon(Icons.favorite_rounded,
                      color: AppColors.brandDark, size: 22),
                  const SizedBox(width: 8),
                  const Text('Acolher',
                      style: TextStyle(
                        color: AppColors.brandDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      )),
                  const Spacer(),
                  if (_index < introPages.length - 1)
                    TextButton(
                      onPressed: _goToApp,
                      child: const Text('Pular',
                          style: TextStyle(color: AppColors.textMuted)),
                    ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _index = i),
                itemCount: introPages.length,
                itemBuilder: (context, i) => _IntroPageView(page: introPages[i]),
              ),
            ),
            // Indicadores de progresso (bolinhas)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                introPages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _index ? 22 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: i == _index
                        ? AppColors.primary
                        : AppColors.textMuted.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            // Ações
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AudioButton(audioFile: introPages[_index].audio),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: introPages[_index].cta,
                      icon: _index == introPages.length - 1
                          ? Icons.check_rounded
                          : Icons.arrow_forward_rounded,
                      onPressed: _next,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPageView extends StatelessWidget {
  const _IntroPageView({required this.page});
  final IntroPage page;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Column(
        children: [
          if (page.stepLabel != null) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(page.stepLabel!,
                  style: const TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 12),
          ],
          AppIllustration(imageName: page.illustration),
          const SizedBox(height: 28),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 25,
              fontWeight: FontWeight.w600,
              height: 1.28,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.body,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
