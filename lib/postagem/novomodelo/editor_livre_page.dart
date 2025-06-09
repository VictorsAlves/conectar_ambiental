import 'package:conectar_ambiental/postagem/novomodelo/bloco_texto.dart' show BlocoTexto;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'bloco_conteudo.dart' show TipoBloco;

class EditorLivrePage extends StatefulWidget {
  const EditorLivrePage({super.key});

  @override
  State<EditorLivrePage> createState() => _EditorLivrePageState();
}

class _EditorLivrePageState extends State<EditorLivrePage> {
  final textoController = TextEditingController();
  final List<BlocoTexto> blocos = [];

  bool negrito = false;
  bool italico = false;
  double tamanhoFonte = 16;

  void adicionarBloco() {
    if (textoController.text.trim().isEmpty) return;

    blocos.add(
      BlocoTexto(
        texto: textoController.text.trim(),
        negrito: negrito,
        italico: italico,
        tamanhoFonte: tamanhoFonte,
      ),
    );

    textoController.clear();
    setState(() {});
  }

  void salvar() {
    final jsonString = jsonEncode(blocos.map((b) => b.toJson()).toList());
    print(jsonString); // Aqui você pode mandar para GitHub ou backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor Manual'),
        actions: [
          IconButton(onPressed: salvar, icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Preview do conteúdo formatado
            Expanded(
              child: ListView.builder(
                itemCount: blocos.length,
                itemBuilder: (_, index) {
                  final b = blocos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(
                      b.texto,
                      style: TextStyle(
                        fontSize: b.tamanhoFonte,
                        fontWeight: b.negrito ? FontWeight.bold : FontWeight.normal,
                        fontStyle: b.italico ? FontStyle.italic : FontStyle.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 32),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textoController,
                    decoration: const InputDecoration(
                      hintText: 'Digite e pressione ENTER',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => adicionarBloco(),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_bold,
                    color: negrito ? Colors.blue : null,
                  ),
                  onPressed: () => setState(() => negrito = !negrito),
                ),
                IconButton(
                  icon: Icon(
                    Icons.format_italic,
                    color: italico ? Colors.blue : null,
                  ),
                  onPressed: () => setState(() => italico = !italico),
                ),
                DropdownButton<double>(
                  value: tamanhoFonte,
                  items: [14, 16, 18, 24, 32]
                      .map((size) => DropdownMenuItem(
                    value: size.toDouble(),
                    child: Text('$size'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => tamanhoFonte = value);
                    }
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
