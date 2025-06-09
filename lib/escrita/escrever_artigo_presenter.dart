import 'dart:convert' show jsonEncode;

import 'package:conectar_ambiental/conteudo/artigo_model.dart';
import 'package:conectar_ambiental/core/interface_presenter.dart';
import 'package:conectar_ambiental/core/conteudo_service.dart';
import 'package:conectar_ambiental/core/credenciais.dart';
import 'package:conectar_ambiental/core/model/indice_item.dart';

class EscreverArtigoPresenter extends IPresenter {
  Future<void> criarArquivoNoGitHub(
      {required String titulo, required Artigo novoConteudo}) async {
    final ConteudoService service = ConteudoService();

    // Converte o Artigo para Map com 'titulos' (em lista)
    final artigoMap = {
      'titulos': [novoConteudo.titulo], // Mantemos como lista
      'paragrafos': novoConteudo.paragrafos,
    };

    final conteudoFinal = jsonEncode(artigoMap);

    // Obter índice atual
    final indice = await service.obterIndice();

    // Encontrar o maior número
    int maiorNumero = 0;

    if (indice.itens.isNotEmpty) {
      maiorNumero =
          indice.itens.map((e) => e.numero).reduce((a, b) => a > b ? a : b);
    }

    // Definir o próximo número
    final int proximoNumero = maiorNumero + 1;

    // Delegar o novo nome do arquivo
    final String nomeArquivo =
        "postagem_${proximoNumero.toString().padLeft(2, '0')}.json";

    // Criar o arquivo no GitHub
    await service.criarArquivoNoGitHub(
      token: token,
      usuario: usuario,
      repo: repo,
      caminhoArquivo: nomeArquivo,
      novoConteudo: conteudoFinal,
      commitMessage: "Criando novo conteúdo: $titulo",
    );

    // Atualizar o índice com o novo item
    IndiceItem newIndiceItem = IndiceItem(
        numero: proximoNumero,
        arquivo: nomeArquivo,
        titulos: [novoConteudo.titulo]);
    indice.itens.add(newIndiceItem);

    await service.atualizarArquivoNoGitHub(
        novoConteudo: indice.toJson().toString(),
        caminhoArquivo: 'indice.json',
        commitMessage: 'atualizando indice',
        repo: repo,
        token: token,
        usuario: usuario);
  }
}
