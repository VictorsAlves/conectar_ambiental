import 'package:conectar_ambiental/postagem/postagem_presenter.dart';
import 'package:flutter/material.dart';
import 'postagem_view_model.dart';

class PostagensPage extends StatefulWidget {

  const PostagensPage({super.key});

  @override
  State<PostagensPage> createState() => _PostagensPageState();
}

class _PostagensPageState extends State<PostagensPage> {
  int paginaAtual = 1;
  late PostagemViewModel postagem;
  PostagemPresenter  presenter = PostagemPresenter();
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarPostagem();
  }

  Future<void> carregarPostagem() async {
    setState(() => carregando = true);
    final data = await presenter.buscarPostagemPorIndice(paginaAtual);
    setState(() {
      postagem = PostagemViewModel.fromJson(data);
      carregando = false;
    });
  }

  void proximaPagina() {
    setState(() => paginaAtual++);
    carregarPostagem();
  }

  void paginaAnterior() {
    if (paginaAtual > 1) {
      setState(() => paginaAtual--);
      carregarPostagem();
    }
  }

  @override
  Widget build(BuildContext context) {
    presenter.setContext(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Postagem $paginaAtual'),
        centerTitle: true,
      ),
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: presenter.minLength(postagem.titulos, postagem.paragrafos),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          postagem.titulos[index],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          postagem.paragrafos[index],
                          style: const TextStyle(fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
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
                Text("Página $paginaAtual"),
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
    );
  }


}
