import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'artigo_model.dart';

class ConteudoPage extends StatefulWidget {
  const ConteudoPage({super.key});

  @override
  State<ConteudoPage> createState() => _ConteudoPageState();
}

class _ConteudoPageState extends State<ConteudoPage> {
  List<Artigo> artigos = [];
  List<Artigo> artigosFiltrados = [];
  int paginaAtual = 0;
  String termoBusca = '';

  @override
  void initState() {
    super.initState();
    carregarJson();
  }

  Future<void> carregarJson() async {
    final String resposta = await rootBundle.loadString('assets/conteudos_biologar.json');
    final data = json.decode(resposta);
    setState(() {
      artigos = List<Artigo>.from(data.map((e) => Artigo.fromJson(e)));
      artigosFiltrados = List.from(artigos);
    });
  }

  void selecionarPagina(int index) {
    setState(() {
      paginaAtual = index;
    });
    Navigator.of(context).pop(); // Fecha o menu lateral
  }

  void filtrarArtigos(String termo) {
    setState(() {
      termoBusca = termo;
      artigosFiltrados = artigos
          .where((a) => a.titulo.toLowerCase().contains(termo.toLowerCase()))
          .toList();
      paginaAtual = 0;
    });
  }

  void proximaPagina() {
    if (paginaAtual < artigosFiltrados.length - 1) {
      setState(() => paginaAtual++);
    }
  }

  void paginaAnterior() {
    if (paginaAtual > 0) {
      setState(() => paginaAtual--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (artigosFiltrados.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final artigo = artigosFiltrados[paginaAtual];

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(
              child: Text(
                "Artigos Biologar",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                onChanged: filtrarArtigos,
                decoration: InputDecoration(
                  hintText: 'Buscar título...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: artigosFiltrados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      artigosFiltrados[index].titulo,
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
        title: Text(artigo.titulo),
        centerTitle: true,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          key: ValueKey(artigo.titulo),
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: artigo.paragrafos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return Text(
                      artigo.paragrafos[index],
                      style: const TextStyle(fontSize: 18, height: 1.5),
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
                    label: const Text("Anterior"),
                  ),
                  const SizedBox(width: 24),
                  Text("Página ${paginaAtual + 1} de ${artigosFiltrados.length}"),
                  const SizedBox(width: 24),
                  ElevatedButton.icon(
                    onPressed: proximaPagina,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Próxima"),
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