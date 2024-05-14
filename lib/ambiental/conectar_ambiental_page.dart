import 'package:carousel_slider/carousel_slider.dart';
import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/ambiental/conectar_ambiental_presenter.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/footer/footer.dart';
import 'package:flutter/material.dart';

class ConectarAmbientalPage extends StatefulWidget {
  const ConectarAmbientalPage({super.key});

  @override
  State<ConectarAmbientalPage> createState() => _ConectarAmbientalPageState();
}

class _ConectarAmbientalPageState extends State<ConectarAmbientalPage>
    with IView {
  double kTamanhoLogo = 0;
  double kTitulo1Tamanho = 0;
  double kTitulo2Tamanho = 0;
  double kTitulo3Tamanho = 0;
  double kImagemTamanho = 0;
  double kcardValoresEmpresaAltura = 0;
  double kcardValoresEmpresaLargura = 0;

  var presenter = ConectarAmbientalPresenter();

  @override
  Widget build(BuildContext context) {
    var altura =  MediaQuery.of(context).size.height;
    var largura =  MediaQuery.of(context).size.width;
    kTamanhoLogo =altura / 15;
    kTitulo1Tamanho = largura / 14;
    kTitulo2Tamanho = largura / 16;
    kTitulo3Tamanho = largura / 20;
    kImagemTamanho = altura / 2.5;
    kcardValoresEmpresaAltura = altura/1;
    kcardValoresEmpresaLargura = largura/1.6;



    presenter.setContext(context);
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/esquilo.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/tucano.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/pica-pau.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: const Color(kCorBgCinza),
              child: Padding(
                padding: const EdgeInsets.only(left: 80, right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Conectar',
                          style: TextStyle(
                            color: const Color(kCorPrimaria),
                            fontSize: kTitulo1Tamanho,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' Ambiental',
                          style: TextStyle(
                            fontSize: kTitulo2Tamanho,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      kDescricaoPaginaPrincipal,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(kCorBgCinza),
              child: Padding(
                padding: const EdgeInsets.all(80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Visão',
                      style: TextStyle(
                        fontSize: kTitulo3Tamanho,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    cardValoresEmpresa(path: kPathVisao, text: kDescricaoVisao),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Missão',
                      style: TextStyle(
                        fontSize: kTitulo3Tamanho,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    cardValoresEmpresa(
                        path: kPathEquipe, text: kDescricaoMissao)
                  ],
                ),
              ),
            ),
            const Footer()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      title: const Text(
        kTitle,
        style: TextStyle(
          color: Color(kCorPrimaria),
          fontSize: 20, // Tamanho do texto
          fontWeight: FontWeight.bold, // Negrito
        ),
      ),
      centerTitle: true,
      leading: customLogo(tamanhoLogo: kTamanhoLogo),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  presenter.navigateTo();
                },
                child: const Text('Inicio'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Serviços'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget customLogo({required double tamanhoLogo}) {
    return Row(
      children: [
        Image.asset(
          'assets/LOGO_AMBIENTAL_FUNDO TRABSPARENTE_OP1.png',
          // Caminho para a imagem do logo
          height: tamanhoLogo, // Altura da imagem
        ),
      ],
    );
  }

  Widget cardValoresEmpresa({required String path, required String text}) {
    return SizedBox(
      height: kcardValoresEmpresaAltura,
      width: kcardValoresEmpresaLargura,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: kImagemTamanho,
                width: kImagemTamanho,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage(path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(64.0),
              child: Text(
                textAlign: TextAlign.left,
                text,
                style: const TextStyle(
                  fontSize: 16,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void setContext(BuildContext context) {
    presenter.setContext(context);
  }

  @override
  void defineState() {
    // TODO: implement defineState
  }

  @override
  IView getView() {
    return this;
  }
}
