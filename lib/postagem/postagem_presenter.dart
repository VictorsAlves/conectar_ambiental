import 'package:conectar_ambiental/core/interface_presenter.dart';
import 'package:conectar_ambiental/core/conteudo_service.dart';


class PostagemPresenter extends IPresenter {
  Future<Map<String, dynamic>> buscarPostagemPorIndice(int paginaAtual) async {
    ConteudoService service = ConteudoService();
    String name = 'postagem_$paginaAtual';

    var request = await service.obterPostagem(name);

    return request.toJson(request);
  }

  int minLength(List a, List b) => a.length < b.length ? a.length : b.length;
}
