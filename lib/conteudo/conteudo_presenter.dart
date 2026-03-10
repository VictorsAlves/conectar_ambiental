import 'package:conectar_ambiental/interface_view.dart';
import 'package:conectar_ambiental/core/conteudo_service.dart';
import 'package:conectar_ambiental/core/model/indice_response.dart';
import 'package:conectar_ambiental/core/model/postagem_response.dart';
import 'package:conectar_ambiental/router.dart';
import 'package:flutter/widgets.dart';

class ConteudoPresenter {
  late IView view;
  late BuildContext context;
  late ConectarAmbientalRouter router;

  void setContext(BuildContext context) {
    this.context = context;
    router = ConectarAmbientalRouter(context);
  }

  Future<IndiceResponse> buscarIndice() {
    final ConteudoService conteudo = ConteudoService();
    return conteudo.obterIndice();
  }

  Future<PostagemResponse> buscarPostagemPorArquivo(String arquivo) {
    final ConteudoService conteudo = ConteudoService();
    return conteudo.obterPostagem(arquivo);
  }

  void navigate(int index) {
    switch (index) {
      case 1:
        router.goToAmbiental();
        break;
      case 2:
        router.goToGuaratuba();
      default:
        router.goToInicio();
    }
  }
}
