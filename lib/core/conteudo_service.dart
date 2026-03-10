import 'dart:convert' show base64Encode, json, utf8;

import 'package:conectar_ambiental/core/model/postagem_response.dart';
import 'package:dio/dio.dart' show Dio, Options;

import '../conteudo/artigo_model.dart';
import 'model/indice_item.dart';
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

    final arquivo = name.endsWith('.json') ? name : '$name.json';
    final url =
        'https://raw.githubusercontent.com/ConectarAmbiental/arquivos/main/$arquivo';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = _parseMapPayload(response.data);
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

    const url =
        'https://raw.githubusercontent.com/ConectarAmbiental/arquivos/main/indice.json';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        return _parseIndicePayload(response.data);
      } else {
        throw Exception('Erro ao carregar JSON: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na requisição: $e');
    }
  }

  Map<String, dynamic> _parseMapPayload(dynamic payload) {
    if (payload is Map<String, dynamic>) {
      return payload;
    }

    if (payload is String) {
      final decoded = json.decode(payload);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    }

    throw const FormatException('Formato de JSON invalido para objeto.');
  }

  IndiceResponse _parseIndicePayload(dynamic payload) {
    if (payload is List<dynamic>) {
      return IndiceResponse.fromJson(payload);
    }

    if (payload is Map<String, dynamic> && payload['itens'] is List<dynamic>) {
      return IndiceResponse.fromJson(payload['itens'] as List<dynamic>);
    }

    if (payload is String) {
      try {
        final decoded = json.decode(payload);

        if (decoded is List<dynamic>) {
          return IndiceResponse.fromJson(decoded);
        }

        if (decoded is Map<String, dynamic> && decoded['itens'] is List<dynamic>) {
          return IndiceResponse.fromJson(decoded['itens'] as List<dynamic>);
        }
      } catch (_) {
        return _parseIndiceLegado(payload);
      }
    }

    throw const FormatException('Formato de JSON invalido para indice.');
  }

  // Fallback para ler indice salvo via List<Map>.toString() em versoes antigas.
  IndiceResponse _parseIndiceLegado(String raw) {
    final itemRegex = RegExp(
      r'\{numero:\s*(\d+),\s*arquivo:\s*([^,}]+),\s*titulos:\s*\[(.*?)\]\}',
    );

    final itens = <IndiceItem>[];
    for (final match in itemRegex.allMatches(raw)) {
      final numero = int.tryParse(match.group(1) ?? '');
      final arquivo = (match.group(2) ?? '').trim();
      final tituloRaw = (match.group(3) ?? '').trim();

      if (numero == null || arquivo.isEmpty) {
        continue;
      }

      final titulo = _limparToken(tituloRaw);
      itens.add(
        IndiceItem(
          numero: numero,
          arquivo: arquivo,
          titulos: titulo.isEmpty ? <String>[] : <String>[titulo],
        ),
      );
    }

    if (itens.isEmpty) {
      throw const FormatException('Indice legado invalido.');
    }

    return IndiceResponse(itens: itens);
  }

  String _limparToken(String value) {
    var v = value.trim();
    if ((v.startsWith("'") && v.endsWith("'")) ||
        (v.startsWith('"') && v.endsWith('"'))) {
      v = v.substring(1, v.length - 1);
    }
    return v;
  }

  atualizarIndice({
    required int numero,
    required String nomeArquivo,
    required List<String> titulos,
    required IndiceResponse indice,
  }) {}
}
