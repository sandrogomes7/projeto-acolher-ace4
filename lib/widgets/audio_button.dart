import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../services/audio_service.dart';
import '../theme/app_theme.dart';

/// Botão "Ouvir explicação" reutilizável.
///
/// Recebe o nome do arquivo de áudio (ex.: `intro_0.mp3`) que deve estar
/// em `assets/audio/`. Mostra ícone de play/pause e dá feedback se o áudio
/// ainda não estiver disponível.
class AudioButton extends StatefulWidget {
  const AudioButton({
    super.key,
    required this.audioFile,
    this.label = 'Ouvir explicação',
  });

  final String audioFile;
  final String label;

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {
  final _audio = AudioService.instance;

  bool get _isThisPlaying =>
      _audio.currentFile == widget.audioFile && _audio.isPlaying;

  Future<void> _onTap() async {
    final ok = await _audio.toggle(widget.audioFile);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Áudio "${widget.audioFile}" ainda não foi adicionado.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: _audio.playerStateStream,
      builder: (context, snapshot) {
        final playing = _isThisPlaying;
        return Semantics(
          button: true,
          label: playing ? 'Pausar explicação em áudio' : widget.label,
          child: Material(
            color: AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _onTap,
              child: Container(
                height: 52,
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      playing ? Icons.pause_rounded : Icons.volume_up_rounded,
                      color: AppColors.brandDark,
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      playing ? 'Pausar' : widget.label,
                      style: const TextStyle(
                        color: AppColors.brandDark,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
