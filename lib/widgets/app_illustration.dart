import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Caixa de ilustração da tela.
///
/// Tenta carregar `assets/illustrations/<imageName>`. Enquanto a arte ainda
/// não existe, mostra um placeholder suave (sem quebrar o app). Assim você
/// pode ir colocando as imagens depois, uma a uma.
class AppIllustration extends StatelessWidget {
  const AppIllustration({
    super.key,
    this.imageName,
    this.fallbackIcon = Icons.favorite_rounded,
    this.height = 200,
  });

  final String? imageName;
  final IconData fallbackIcon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: imageName == null
          ? _Placeholder(icon: fallbackIcon)
          : Image.asset(
              'assets/illustrations/$imageName',
              fit: BoxFit.cover,
              // Se a imagem ainda não foi adicionada, cai no placeholder.
              errorBuilder: (_, __, ___) => _Placeholder(icon: fallbackIcon),
            ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 40,
          bottom: 24,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
        ),
        Icon(icon, size: 64, color: AppColors.brandDark),
      ],
    );
  }
}
