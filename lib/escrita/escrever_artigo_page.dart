import 'package:conectar_ambiental/escrita/escrever_artigo_presenter.dart';
import 'package:flutter/material.dart';

import '../conteudo/artigo_model.dart' show Artigo;


class EscreverArtigoPage extends StatefulWidget {
  final EscreverArtigoPresenter presenter = EscreverArtigoPresenter();
   EscreverArtigoPage({super.key,});

  @override
  State<EscreverArtigoPage> createState() => _EscreverArtigoPageState();
}

class _EscreverArtigoPageState extends State<EscreverArtigoPage> {
  final tituloController = TextEditingController();
  final inputController = TextEditingController();

  final List<String> paragrafos = [];

  void adicionarParagrafo() {
    final texto = inputController.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      paragrafos.add(texto);
      if (paragrafos.length > 5) {
        paragrafos.removeAt(0); // remove o mais antigo
      }
    });
    inputController.clear();
  }

  void salvarArtigo() {
    final artigo = Artigo(
      titulo: tituloController.text.trim(),
      paragrafos: List.from(paragrafos),
    );

    widget.presenter.criarArquivoNoGitHub(
        titulo: artigo.titulo,
        novoConteudo: artigo);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    widget.presenter.setContext(context);
    final estiloMaquina = BoxDecoration(
      color: Colors.grey[200],
      border: Border.all(color: Colors.grey.shade700, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escrever Artigo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: salvarArtigo,
            tooltip: 'Salvar',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('Título:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            const Text('Folha de Papel:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              decoration: estiloMaquina,
              padding: const EdgeInsets.all(12),
              height: 200, // altura fixa para os parágrafos
              child: ListView.builder(
                itemCount: paragrafos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      paragrafos[index],
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            const Spacer(), // empurra o input para o final
            Container(
              decoration: estiloMaquina,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: inputController,
                      maxLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Digite e aperte Enter',
                      ),
                      onSubmitted: (text) => adicionarParagrafo(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: adicionarParagrafo,
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
