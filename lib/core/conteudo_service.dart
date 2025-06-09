import 'dart:convert' show base64Encode, json, utf8;

import 'package:conectar_ambiental/core/model/postagem_response.dart';
import 'package:dio/dio.dart' show Dio, Options;

import '../conteudo/artigo_model.dart';
import 'model/indice_response.dart';

class ConteudoService {
  Future<List<Artigo>> carregarArtigos() async {
    final dio = Dio();

    const url =
        'https://raw.githubusercontent.com/ConectarAmbiental/arquivos/main/conteudos_biologar.json';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.data);
        return data.map((e) => Artigo.fromJson(e)).toList();
      } else {
        throw Exception('Erro ao carregar JSON: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<void> atualizarArquivoNoGitHub({
    required String token,
    required String usuario,
    required String repo,
    required String caminhoArquivo,
    required String novoConteudo,
    required String commitMessage,
  }) async {
    final dio = Dio();

    final apiUrl =
        'https://api.github.com/repos/$usuario/$repo/contents/$caminhoArquivo';

    try {
      // 1. Obter SHA atual
      final getResponse = await dio.get(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'token $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );

      final sha = getResponse.data['sha'];

      // 2. Codificar conteúdo para Base64
      final base64Content = base64Encode(utf8.encode(novoConteudo));

      // 3. Fazer PUT
      final putResponse = await dio.put(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'token $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
        data: {
          "message": commitMessage,
          "content": base64Content,
          "sha": sha,
        },
      );

      print(
          '✅ Arquivo atualizado com sucesso: ${putResponse.data['commit']['sha']}');
    } catch (e) {
      print('❌ Erro ao atualizar arquivo: $e');
      rethrow;
    }
  }

  Future<void> criarArquivoNoGitHub({
    required String token,
    required String usuario,
    required String repo,
    required String caminhoArquivo,
    required String novoConteudo,
    required String commitMessage,
  }) async {
    final dio = Dio();

    final apiUrl =
        'https://api.github.com/repos/$usuario/$repo/contents/$caminhoArquivo';

    try {
      // 1. Codificar conteúdo para Base64
      final base64Content = base64Encode(utf8.encode(novoConteudo));

      // 2. Fazer PUT
      final putResponse = await dio.put(
        apiUrl,
        options: Options(
          headers: {
            'Authorization': 'token $token',
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
        data: {
          "message": commitMessage,
          "content": base64Content,
        },
      );

      print(
          '✅ Arquivo criado com sucesso: ${putResponse.data['commit']['sha']}');
    } catch (e) {
      print('❌ Erro ao criar arquivo: $e');
      rethrow;
    }
  }

  Future<PostagemResponse> obterPostagem(String name) async {
    final dio = Dio();

    var url =
        'https://raw.githubusercontent.com/ConectarAmbiental/arquivos/main/$name.json';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.data);
        return PostagemResponse.fromJson(data);
      } else if (response.statusCode == 404) {
        return PostagemResponse.fromJson({});
      } else {
        throw Exception('Erro ao carregar JSON: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Future<IndiceResponse> obterIndice() async {
    final dio = Dio();

    var url =
        'https://raw.githubusercontent.com/ConectarAmbiental/arquivos/main/indice.json';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.data);
        return IndiceResponse.fromJson(data);
      } else {
        throw Exception('Erro ao carregar JSON: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  atualizarIndice({
    required int numero,
    required String nomeArquivo,
    required List<String> titulos,
    required IndiceResponse indice,
  }) {}
}
