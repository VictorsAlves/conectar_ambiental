import 'package:flutter/material.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/ambiental/conectar_ambiental_presenter.dart';

import '../footer/footer.dart';

class ConectarAmbientalPage extends StatefulWidget {
  const ConectarAmbientalPage({super.key});

  @override
  State<ConectarAmbientalPage> createState() => _ConectarAmbientalPageState();
}

class _ConectarAmbientalPageState extends State<ConectarAmbientalPage> {
  final presenter = ConectarAmbientalPresenter();
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      _isScrolled = _scrollController.offset > 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(theme, size),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Banner Hero
          SliverToBoxAdapter(
            child: Container(
              height: size.height * 0.7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(kTucanoImg),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withAlpha(3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Soluções Sustentáveis\npara um Futuro Verde',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Seção de Serviços
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: 40),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 800 ? 3 : 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildServiceCard(index, theme),
                childCount: 6,
              ),
            ),
          ),

          // Seção Sobre Nós
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: 60),
              color: Colors.grey[50],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nossa História',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              kDescricaoPaginaPrincipal,
                              style: theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 30),
                            _buildMissionVisionCard(
                              'Missão',
                              kDescricaoMissao,
                              theme,
                            ),
                            const SizedBox(height: 20),
                            _buildMissionVisionCard(
                              'Visão',
                              kDescricaoVisao,
                              theme,
                            ),
                          ],
                        ),
                      ),
                      if (size.width > 800)
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              kPathEquipe,
                              width: 400,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Seção de Publicações
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: 60),
              child: Column(
                children: [
                  Text(
                    'Últimas Publicações',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildPublicationsSlider(size),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => presenter.navigateTo(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Ver Todas as Publicações'),
                  ),
                ],
              ),
            ),
          ),

          // Rodapé
          const SliverToBoxAdapter(
            child: Footer(),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, Size size) {
    return AppBar(
      backgroundColor:
          _isScrolled ? theme.primaryColor : Colors.transparent,
      elevation: _isScrolled ? 4 : 0,
      title: Image.asset(
        _isScrolled ? kPathLogoAmbientalBranco : kPathLogoAmbiental,
        height: 50,
      ),
      centerTitle: true,
      actions: [
        if (size.width > 600)
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child:  Text(
                  'Início',
                  style: _isScrolled
                      ?  TextStyle(
                          color: theme.secondaryHeaderColor, fontWeight: FontWeight.bold)
                      : const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => _scrollController.animateTo(
                  MediaQuery.of(context).size.height * 0.7,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child:  Text('Serviços',style: _isScrolled
                    ?  TextStyle(
                    color: theme.secondaryHeaderColor, fontWeight: FontWeight.bold)
                    : const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              TextButton(
                onPressed: () => _scrollController.animateTo(
                  MediaQuery.of(context).size.height * 1.8,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child:  Text('Sobre Nós', style: _isScrolled
                    ?  TextStyle(
                    color: theme.secondaryHeaderColor, fontWeight: FontWeight.bold)
                    : const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              TextButton(
                onPressed: () => presenter.navigateTo(),
                child:  Text('Publicações', style: _isScrolled
                    ?  TextStyle(
                    color: theme.secondaryHeaderColor, fontWeight: FontWeight.bold)
                    : const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(width: 20),
            ],
          ),
      ],
    );
  }

  Widget _buildServiceCard(int index, ThemeData theme) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              services[index].icon,
              size: 50,
              color: theme.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              services[index].title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            const Text(
              'Saiba mais sobre nossos serviços especializados nesta área',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionVisionCard(String title, String text, ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              text,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPublicationsSlider(Size size) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: size.width * 0.8,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    child: Image.asset(
                      kEsquiloImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Título da Publicação ${index + 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Resumo da publicação com os principais pontos abordados no artigo técnico ou notícia ambiental...',
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Ler Mais'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Service {
  final String title;
  final IconData icon;

  const Service(this.title, this.icon);
}

final List<Service> services = [
  Service('Licenciamento Ambiental', Icons.assignment_turned_in),
  Service('Recuperação de Áreas', Icons.nature),
  Service('Educação Ambiental', Icons.school),
  Service('Laudos Técnicos', Icons.assessment),
  Service('Resgate de Fauna', Icons.pets),
  Service('Consultoria Personalizada', Icons.people),
];
