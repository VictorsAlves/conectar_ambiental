import 'package:conectar_ambiental/conteudo/conteudo_presenter.dart';
import 'package:conectar_ambiental/core/model/indice_item.dart';
import 'package:conectar_ambiental/core/model/postagem_response.dart';
import 'package:flutter/material.dart';

class ConteudoPage extends StatefulWidget {
  ConteudoPage({super.key});
  final ConteudoPresenter presenter = ConteudoPresenter();

  @override
  State<ConteudoPage> createState() => _ConteudoPageState();
}

class _ConteudoPageState extends State<ConteudoPage> {
  List<IndiceItem> indice = [];
  List<IndiceItem> indiceFiltrado = [];
  PostagemResponse? postagemAtual;

  int paginaAtual = 0;
  String termoBusca = '';
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarIndice();
  }

  Future<void> carregarIndice() async {
    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final data = await widget.presenter.buscarIndice();
      final itens = List<IndiceItem>.from(data.itens);

      if (itens.isEmpty) {
        setState(() {
          indice = [];
          indiceFiltrado = [];
          postagemAtual = null;
          carregando = false;
        });
        return;
      }

      indice = itens;
      indiceFiltrado = List<IndiceItem>.from(itens);
      paginaAtual = 0;
      await carregarPostagemDaPaginaAtual();
    } catch (e) {
      setState(() {
        erro = e.toString();
        carregando = false;
      });
    }
  }

  Future<void> carregarPostagemDaPaginaAtual() async {
    if (indiceFiltrado.isEmpty) {
      setState(() {
        postagemAtual = null;
        carregando = false;
      });
      return;
    }

    setState(() {
      carregando = true;
      erro = null;
    });

    try {
      final item = indiceFiltrado[paginaAtual];
      final postagem =
          await widget.presenter.buscarPostagemPorArquivo(item.arquivo);

      setState(() {
        postagemAtual = postagem;
        carregando = false;
      });
    } catch (e) {
      setState(() {
        erro = e.toString();
        carregando = false;
      });
    }
  }

  String tituloDoIndice(IndiceItem item) {
    if (item.titulos.isNotEmpty) {
      return item.titulos.first;
    }
    return 'Postagem ${item.numero}';
  }

  Future<void> selecionarPagina(int index) async {
    setState(() {
      paginaAtual = index;
    });
    Navigator.of(context).pop();
    await carregarPostagemDaPaginaAtual();
  }

  void filtrarArtigos(String termo) {
    final busca = termo.toLowerCase();

    setState(() {
      termoBusca = termo;
      if (termo.isEmpty) {
        indiceFiltrado = List<IndiceItem>.from(indice);
      } else {
        indiceFiltrado = indice.where((item) {
          final titulo = tituloDoIndice(item).toLowerCase();
          return titulo.contains(busca);
        }).toList();
      }
      paginaAtual = 0;

      // Apenas atualiza a lista, sem carregar postagem
      // A postagem será carregada ao selecionar um item
      if (indiceFiltrado.isEmpty) {
        postagemAtual = null;
      }
    });
  }

  Future<void> proximaPagina() async {
    if (paginaAtual < indiceFiltrado.length - 1) {
      setState(() => paginaAtual++);
      await carregarPostagemDaPaginaAtual();
    }
  }

  Future<void> paginaAnterior() async {
    if (paginaAtual > 0) {
      setState(() => paginaAtual--);
      await carregarPostagemDaPaginaAtual();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.setContext(context);

    if (carregando && indice.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (erro != null && indice.isEmpty) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Erro ao carregar conteudos.\n$erro',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    // Se a busca retornou vazio, mostrar o drawer com a busca vazia
    if (indiceFiltrado.isEmpty) {
      return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              const DrawerHeader(
                child: Text(
                  'Artigos Biologar',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  onChanged: filtrarArtigos,
                  decoration: InputDecoration(
                    hintText: 'Buscar titulo...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: indice.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        tituloDoIndice(indice[index]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => selecionarPagina(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Nenhuma postagem encontrada'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Nenhuma postagem corresponde à sua busca.'),
        ),
      );
    }

    final itemAtual = indiceFiltrado[paginaAtual];
    final tituloTela = tituloDoIndice(itemAtual);
    final paragrafos = postagemAtual?.paragrafos ?? [];

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text(
                'Artigos Biologar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onChanged: filtrarArtigos,
                decoration: InputDecoration(
                  hintText: 'Buscar titulo...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: indiceFiltrado.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      tituloDoIndice(indiceFiltrado[index]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    selected: index == paginaAtual,
                    onTap: () => selecionarPagina(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(tituloTela),
        centerTitle: true,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Padding(
                key: ValueKey(itemAtual.arquivo),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: paragrafos.isEmpty
                          ? const Center(child: Text('Conteúdo não disponível'))
                          : ListView.separated(
                              itemCount: paragrafos.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, index) {
                                return Text(
                                  paragrafos[index],
                                  style: const TextStyle(
                                      fontSize: 18, height: 1.5),
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: paginaAnterior,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Anterior'),
                        ),
                        const SizedBox(width: 24),
                        Text(
                            'Pagina ${paginaAtual + 1} de ${indiceFiltrado.length}'),
                        const SizedBox(width: 24),
                        ElevatedButton.icon(
                          onPressed: proximaPagina,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Proxima'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}