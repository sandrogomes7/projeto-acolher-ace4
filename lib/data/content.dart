import 'package:flutter/material.dart';

/// ===================================================================
/// CONTEÚDO + FLUXOGRAMA DO APP "Acolhimento Digital"
///
/// Aqui ficam:
///   1) Os textos de cada tela (retirados do Figma e do fluxograma).
///   2) O campo `audio`       -> nome do .mp3 em assets/audio/
///   3) O campo `illustration`-> nome da imagem em assets/illustrations/
///   4) A ÁRVORE DE DECISÃO da jornada da paciente (motor `journeyForOnboarding`).
///
/// Para mudar conteúdo, áudio ou ilustração, edite SÓ este arquivo.
/// ===================================================================

/// ---------- Carrossel de introdução (telas 0 a 5) ----------
class IntroPage {
  final String title;
  final String body;
  final String? stepLabel;
  final String cta;
  final String audio; // assets/audio/<audio>
  final String illustration; // assets/illustrations/<illustration>

  const IntroPage({
    required this.title,
    required this.body,
    required this.cta,
    required this.audio,
    required this.illustration,
    this.stepLabel,
  });
}

const List<IntroPage> introPages = [
  IntroPage(
    title: 'Vamos te acompanhar',
    body:
        'Este app explica, com calma, cada passo do seu cuidado. Você pode ouvir tudo em áudio.',
    cta: 'Começar',
    audio: 'intro_0.mp3',
    illustration: 'intro_0.png',
  ),
  IntroPage(
    title: 'O exame preventivo',
    body:
        '''É o exame que você fez no posto. Ele serve para olhar o colo do útero e ter certeza de que está tudo bem.

Existem dois tipos principais desse exame:

Papanicolau: É o mais comum. Ele procura por pequenas alterações nas células do útero.

DNA de HPV: É um exame mais moderno. Ele procura diretamente pelo vírus que pode causar essas alterações.''',
    stepLabel: 'Passo 1 de 5',
    cta: 'Próximo',
    audio: 'intro_1.mp3',
    illustration: 'intro_1.png',
  ),
  IntroPage(
    title: 'Seu resultado veio alterado',
    body:
        'Alterado não quer dizer câncer. Quer dizer que precisamos olhar melhor, por segurança.',
    stepLabel: 'Passo 2 de 5',
    cta: 'Próximo',
    audio: 'intro_2.mp3',
    illustration: 'intro_2.png',
  ),
  IntroPage(
    title: 'Você vai a um serviço especial',
    body:
        'Lá tem médico para olhar de perto. É normal e seguro. Leve seu documento e o resultado do exame.',
    stepLabel: 'Passo 3 de 5',
    cta: 'Próximo',
    audio: 'intro_3.mp3',
    illustration: 'intro_3.png',
  ),
  IntroPage(
    title: 'O que é colposcopia',
    body:
        'Um aparelho vê o colo do útero de pertinho. Não corta. Pode sentir um leve incômodo, como no preventivo.',
    stepLabel: 'Passo 4 de 5',
    cta: 'Próximo',
    audio: 'intro_4.mp3',
    illustration: 'intro_4.png',
  ),
  IntroPage(
    title: 'Você não está sozinha',
    body:
        'Siga as orientações da equipe. Volte sempre que marcarem. Estamos com você.',
    stepLabel: 'Passo 5 de 5',
    cta: 'Concluir',
    audio: 'intro_5.mp3',
    illustration: 'intro_5.png',
  ),
];

/// ---------- Onboarding "Onde você está" ----------
const String onboardingTitle = 'Onde você está agora?';
const String onboardingSubtitle =
    'Toque na etapa em que você está. O app não guarda nenhuma informação sobre você.';

/// As opções estão na MESMA ordem usada pelo motor `journeyForOnboarding`.
const List<String> onboardingOptions = [
  'Fiz o exame preventivo Papanicolau ou Teste DNA HPV', // 0
  'Recebi um resultado alterado no exame de triagem preventivo', // 1
  'Fui encaminhada a outro serviço', // 2
  'Vou fazer a colposcopia', // 3
  'Já fiz a colposcopia', // 4
  'Não sei — quero ver tudo', // 5 (modo explorar todos os caminhos)
];

/// ===================================================================
/// CONTEÚDO DAS ETAPAS (nós do fluxograma)
/// ===================================================================
class StepSection {
  final String label;
  final String text;
  final String? audioFile;
  const StepSection(this.label, this.text, {this.audioFile});
}

class CollectionTabContent {
  final String id;
  final String label;
  final List<StepSection> sections;
  final String tip;

  const CollectionTabContent({
    required this.id,
    required this.label,
    required this.sections,
    required this.tip,
  });
}

/// Conteúdo de uma etapa — independente da posição na jornada.
class StepContent {
  final String id;
  final String title;
  final String summary; // frase curta mostrada no card "Você está aqui"
  final String reassurance;
  final List<StepSection> sections;
  final List<CollectionTabContent>? tabs;
  final String tip;
  final String audio; // assets/audio/<audio>
  final String illustration; // assets/illustrations/<illustration>

  const StepContent({
    required this.id,
    required this.title,
    required this.summary,
    required this.reassurance,
    required this.sections,
    this.tabs,
    required this.tip,
    required this.audio,
    required this.illustration,
  });
}

/// Ícones de cada opção do onboarding (mesma ordem de onboardingOptions).
const List<IconData> onboardingIcons = [
  Icons.assignment_outlined, // Fiz o exame preventivo
  Icons.favorite_outline_rounded, // Recebi um resultado alterado
  Icons.local_hospital_outlined, // Fui encaminhada a outro serviço
  Icons.search_rounded, // Vou fazer a colposcopia
  Icons.assignment_turned_in_outlined, // Já fiz a colposcopia
  Icons.help_outline_rounded, // Não sei — quero ver tudo
];

/// Mapa central de todos os nós do fluxograma.
const Map<String, StepContent> stepContents = {
  'coleta': StepContent(
    id: 'coleta',
    title: 'Coleta do preventivo',
    summary: 'O primeiro passo do seu cuidado, feito no posto.',
    reassurance: 'A coleta é rápida. Se sentir medo, avise a profissional.',
    sections: [],
    tabs: [
      CollectionTabContent(
        id: 'papanicolau',
        label: 'Papanicolau',
        tip:
            'Depois da coleta, aguarde o resultado e siga a orientação da equipe. O exame costuma ser realizado todo ano nos dois primeiros anos e, se estiver tudo certo, repetido a cada 3 anos.',
        sections: [
          StepSection('O que é o Papanicolau',
              'O preventivo, ou Papanicolau, é um exame simples feito no posto. A enfermeira coleta uma pequena amostra do colo do útero através de uma escovinha, sem dor, para ver se está tudo bem.',
              audioFile: 'coleta_papanicolau_o_que_e.mp3'
              // audioFile: 'coleta_papanicolau_o_que_e.mp3',
              ),
          StepSection(
            'Como funciona',
            'Você se deita como no preventivo. A profissional usa um pequeno instrumento para visualizar o colo do útero e coleta a amostra com uma escovinha ou espátula. Pode causar um leve incômodo, mas costuma ser rápido.',
            audioFile: 'coleta_papanicolau_como_funciona.mp3',
          ),
          StepSection(
            'Requisitos para o exame',
            '• Evite relações sexuais, inclusive com camisinha, de 24 a 48 horas antes.\n• Não use duchas vaginais, cremes, óvulos ou lubrificantes nos 2 dias anteriores.\n• Não esteja menstruada. O ideal é fazer de 5 a 7 dias depois que o sangramento terminar.',
            audioFile: 'coleta_papanicolau_requisitos.mp3',
          ),
        ],
      ),
      CollectionTabContent(
        id: 'dna-hpv',
        label: 'Teste DNA HPV',
        tip:
            'Depois da coleta, aguarde o resultado e siga a orientação da equipe. O exame costuma ser realizado todo ano nos dois primeiros anos e, se estiver tudo certo, repetido a cada 3 anos.',
        sections: [
          StepSection(
            'O que é o Teste DNA HPV',
            'É um exame feito com a coleta no colo do útero. Ele procura sinais do HPV, vírus que pode causar alterações antes de virar doença.',
            audioFile: 'coleta_dna_hpv_o_que_e.mp3',
          ),
          StepSection(
            'Por que ele é importante',
            'Quando encontra o vírus cedo, a equipe consegue acompanhar melhor e evitar problemas no futuro. A coleta é parecida com a do preventivo.',
            audioFile: 'coleta_dna_hpv_importancia.mp3',
          ),
          StepSection(
            'Requisitos para o exame',
            '• Evite relações sexuais, inclusive com camisinha, de 24 a 48 horas antes.\n• Não use duchas vaginais, cremes, óvulos ou lubrificantes nos 2 dias anteriores.\n• Não esteja menstruada. O ideal é fazer de 5 a 7 dias depois que o sangramento terminar.\n• Avise a profissional se estiver grávida ou se houver suspeita de gravidez.',
            audioFile: 'coleta_dna_hpv_requisitos.mp3',
          ),
        ],
      ),
    ],
    tip: 'Depois da coleta, aguarde o resultado e siga a orientação da equipe.',
    audio: 'etapa_coleta.mp3',
    illustration: 'etapa_coleta.png',
  ),
  'resultado': StepContent(
    id: 'resultado',
    title: 'Resultado do exame',
    summary: 'Agora é entender o que o resultado do seu exame indica.',
    reassurance: 'Receber um resultado pode dar medo. Vamos com calma.',
    sections: [
      StepSection('Tudo certo (NILM)',
          'Não achou alteração. Você volta para a rotina do posto.'),
      StepSection('Alteração leve (ASC-US, LSIL)',
          'Pequena alteração. Muitas somem sozinhas — você só repete o exame depois.'),
      StepSection('Alteração importante (ASC-H, HSIL, AGC e AIS)',
          'Aí sim você vai para um exame mais detalhado: a colposcopia.'),
    ],
    tip: 'O resultado pode seguir três caminhos. Veja o seu com a equipe.',
    audio: 'etapa_resultado.mp3',
    illustration: 'etapa_resultado.png',
  ),
  'encaminhamento': StepContent(
    id: 'encaminhamento',
    title: 'Encaminhamento',
    summary:
        'Seu preventivo teve uma alteração. Por isso você foi a um serviço especializado.',
    reassurance: 'Respire. Vamos com calma, juntas nisso.',
    sections: [
      StepSection('Por que você está aqui',
          'Seu exame preventivo teve uma alteração. Por isso a equipe de saúde te encaminhou para um serviço especializado em ginecologia.'),
      StepSection('O que acontece agora',
          'Nesse serviço, um médico vai examinar o colo do útero bem de perto, com um exame chamado colposcopia. É normal e seguro.'),
    ],
    tip: 'Leve seu documento e o resultado do preventivo.',
    audio: 'etapa_encaminhamento.mp3',
    illustration: 'etapa_encaminhamento.png',
  ),
  'colposcopia': StepContent(
    id: 'colposcopia',
    title: 'Colposcopia',
    summary: 'É o seu próximo exame. Saber o que esperar ajuda.',
    reassurance: 'É normal sentir ansiedade. Saber o que esperar ajuda.',
    sections: [],
    tabs: [
      CollectionTabContent(
        id: 'colposcopia',
        label: 'Colposcopia',
        tip:
            'Não esqueça de levar o encaminhamento para o centro especializado, assim como o resultado da citologia ou do Teste DNA HPV feito anteriormente.',
        sections: [
          StepSection(
            'O que é a colposcopia',
            'É um exame em que o médico usa um aparelho com luz e lente para ver o colo do útero bem de perto. Não corta e não entra no corpo.',
            audioFile: 'colposcopia_o_que_e.mp3',
          ),
          StepSection(
            'Como funciona',
            'Você fica deitada, como no preventivo. Pode sentir um leve incômodo e dura poucos minutos. Às vezes o médico coleta um pedacinho semelhante a um grão de areia para examinar.',
            audioFile: 'colposcopia_como_funciona.mp3',
          ),
          StepSection(
            'Requisitos para o exame',
            '• Evite relações sexuais, inclusive com camisinha, de 24 a 48 horas antes.\n• Não use duchas vaginais, cremes, óvulos ou lubrificantes vaginais nos 2 dias anteriores.\n• Não esteja menstruada. O ideal é realizar o exame de 5 a 7 dias após o término do sangramento.\n• Informe ao médico caso esteja grávida ou com suspeita de gravidez.',
            audioFile: 'colposcopia_requisitos.mp3',
          ),
        ],
      ),
      CollectionTabContent(
        id: 'biopsia',
        label: 'Biópsia',
        tip:
            'Depois da biópsia, aguarde o resultado e siga a orientação da equipe.',
        sections: [
          StepSection(
            'O que é a biópsia',
            'Se o médico encontrar qualquer área suspeita durante a colposcopia, ele retira um pedacinho de tecido, semelhante ao tamanho de um grão de areia, para confirmar o diagnóstico em laboratório.',
            audioFile: 'biopsia_o_que_e.mp3',
          ),
          StepSection(
            'Como funciona',
            'Você fica deitada, como no preventivo. Pode sentir um leve incômodo e dura poucos minutos. Às vezes o médico coleta um pedacinho para examinar.',
            audioFile: 'biopsia_como_funciona.mp3',
          ),
        ],
      ),
    ],
    tip: 'Não esqueça de levar o encaminhamento para o centro especializado.',
    audio: 'etapa_colposcopia.mp3',
    illustration: 'etapa_colposcopia.png',
  ),
  'acompanhamento': StepContent(
    id: 'acompanhamento',
    title: 'Conduta e acompanhamento',
    summary: 'O cuidado continua. Veja o que acontece depois.',
    reassurance: 'Você chegou até aqui. Estamos com você.',
    sections: [
      StepSection('O que acontece depois',
          'Com o resultado da biópsia, o médico decide o cuidado: pode ser só acompanhar de perto (Normal, NIC I), uma pequena cirurgia (NIC II, NIC III) ou um serviço especializado em casos mais sérios. Cada caso é único.'),
      StepSection('Por que continuar indo',
          'Manter as consultas garante que tudo seja acompanhado e resolvido cedo. Não falte às datas marcadas.'),
    ],
    tip: 'Volte sempre que a equipe marcar. Anote as datas.',
    audio: 'etapa_acompanhamento.mp3',
    illustration: 'etapa_acompanhamento.png',
  ),
  // ----- Nós terminais dos caminhos A e B (aparecem em "todos os caminhos") -----
  'rotina': StepContent(
    id: 'rotina',
    title: 'Volta à rotina',
    summary: 'Resultado normal. Veja como seguir a rotina.',
    reassurance: 'Resultado normal. Continue se cuidando.',
    sections: [
      StepSection('O que significa (NILM)',
          'Seu exame não mostrou alterações. Você não precisa de exames avançados agora.'),
      StepSection('O que fazer',
          'Você volta ao rastreamento de rotina no posto. Em geral, repete o preventivo a cada 3 anos (ou conforme a equipe orientar).'),
    ],
    tip: 'Não deixe de repetir o preventivo no prazo.',
    audio: 'etapa_rotina.mp3',
    illustration: 'etapa_rotina.png',
  ),
  'repetir': StepContent(
    id: 'repetir',
    title: 'Repetir o preventivo',
    summary: 'Alteração leve. Veja por que é só repetir o exame.',
    reassurance: 'Alteração leve não é motivo para se assustar.',
    sections: [
      StepSection('O que significa (ASC-US, LSIL)',
          'É uma alteração pequena. Muitas dessas alterações desaparecem sozinhas, sem precisar de tratamento.'),
      StepSection('O que fazer',
          'A conduta costuma ser só repetir o exame preventivo depois de um tempo, no prazo que a equipe indicar. Você continua acompanhada no posto.'),
    ],
    tip: 'Volte para repetir o exame na data combinada.',
    audio: 'etapa_repetir.mp3',
    illustration: 'etapa_repetir.png',
  ),
};

/// ===================================================================
/// MOTOR DA JORNADA — monta o caminho da paciente conforme o perfil
/// ===================================================================
enum StepStatus { done, current, next, later }

class PlannedStep {
  final StepContent content;
  final StepStatus status;
  final String statusLabel; // "Concluído", "Você está aqui"...
  const PlannedStep(this.content, this.status, this.statusLabel);
}

class JourneyPlan {
  final String headline;
  final List<PlannedStep> steps;
  const JourneyPlan({
    required this.headline,
    required this.steps,
  });
}

PlannedStep _p(String id, StepStatus s, String label) =>
    PlannedStep(stepContents[id]!, s, label);

/// Recebe o índice escolhido no onboarding e devolve a jornada.
JourneyPlan journeyForOnboarding(int index) {
  switch (index) {
    case 0: // Fiz o exame preventivo -> aguardando resultado
      return JourneyPlan(
        headline: 'Você fez o preventivo. Agora é aguardar o resultado.',
        steps: [
          _p('coleta', StepStatus.done, 'Concluído'),
          _p('resultado', StepStatus.current, 'Você está aqui'),
          _p('encaminhamento', StepStatus.next, 'Próxima etapa'),
          _p('colposcopia', StepStatus.later, 'Depois'),
          _p('acompanhamento', StepStatus.later, 'Depois'),
        ],
      );
    case 1: // Recebi um resultado alterado
    case 2: // Fui encaminhada a outro serviço
      return JourneyPlan(
        headline:
            'Seu exame teve uma alteração. Vamos juntas no próximo passo.',
        steps: [
          _p('coleta', StepStatus.done, 'Concluído'),
          _p('resultado', StepStatus.done, 'Concluído'),
          _p('encaminhamento', StepStatus.current, 'Você está aqui'),
          _p('colposcopia', StepStatus.next, 'Próxima etapa'),
          _p('acompanhamento', StepStatus.later, 'Depois'),
        ],
      );
    case 3: // Vou fazer a colposcopia
      return JourneyPlan(
        headline:
            'A colposcopia é o seu próximo passo. Saber o que esperar ajuda.',
        steps: [
          _p('coleta', StepStatus.done, 'Concluído'),
          _p('resultado', StepStatus.done, 'Concluído'),
          _p('encaminhamento', StepStatus.done, 'Concluído'),
          _p('colposcopia', StepStatus.current, 'Você está aqui'),
          _p('acompanhamento', StepStatus.next, 'Próxima etapa'),
        ],
      );
    case 4: // Já fiz a colposcopia
      return JourneyPlan(
        headline: 'Você já fez a colposcopia. Agora é o acompanhamento.',
        steps: [
          _p('coleta', StepStatus.done, 'Concluído'),
          _p('resultado', StepStatus.done, 'Concluído'),
          _p('encaminhamento', StepStatus.done, 'Concluído'),
          _p('colposcopia', StepStatus.done, 'Concluído'),
          _p('acompanhamento', StepStatus.current, 'Você está aqui'),
        ],
      );
    case 5: // Não sei — quero ver tudo
    default:
      return JourneyPlan(
        headline: 'Veja a jornada completa, com calma.',
        steps: [
          _p('coleta', StepStatus.current, 'Comece por aqui'),
          _p('resultado', StepStatus.next, 'Próxima etapa'),
          _p('encaminhamento', StepStatus.later, 'Depois'),
          _p('colposcopia', StepStatus.later, 'Depois'),
          _p('acompanhamento', StepStatus.later, 'Depois'),
        ],
      );
  }
}

/// ---------- Tira-dúvidas ----------
class FaqItem {
  final String question;
  final String answer;
  const FaqItem(this.question, this.answer);
}

const List<FaqItem> faqItems = [
  FaqItem('Resultado alterado é câncer?',
      'Não. Quer dizer que algo precisa ser olhado com mais atenção. Não é um diagnóstico de câncer.'),
  FaqItem('A colposcopia dói?',
      'Geralmente não. Pode causar um leve incômodo, parecido com o preventivo, e dura poucos minutos.'),
  FaqItem('Preciso levar algo no dia?',
      'Leve seu documento e o resultado do preventivo. Use roupas confortáveis.'),
  FaqItem('Posso ir acompanhada?',
      'Sim. Você pode levar alguém de confiança para te dar apoio.'),
];

class GlossaryItem {
  final String term;
  final String meaning;
  const GlossaryItem(this.term, this.meaning);
}

const List<GlossaryItem> glossary = [
  GlossaryItem('Papanicolau', 'O exame preventivo do colo do útero.'),
  GlossaryItem('Colposcopia', 'Exame que vê o colo de pertinho.'),
  GlossaryItem('Biópsia', 'Coleta de um pedacinho para examinar.'),
];

/// ---------- Apoio ----------
const String supportHighlightTitle = 'Sentir medo é normal';
const String supportHighlightBody =
    'Respire fundo. Você está cuidando de você e isso já é coragem.';

const List<String> supportMessages = [
  'Um passo de cada vez.',
  'Você não está sozinha.',
  'Pedir ajuda é se cuidar.',
];

class SupportContact {
  final String title;
  final String subtitle;
  final IconData icon;
  const SupportContact(this.title, this.subtitle, this.icon);
}

const List<SupportContact> supportContacts = [
  SupportContact('Unidade de referência',
      'Procure o posto onde você se consulta.', Icons.location_on_rounded),
  SupportContact('Disque Saúde — 136',
      'Ligação gratuita do Ministério da Saúde.', Icons.phone_rounded),
];
