import 'package:carousel_slider/carousel_slider.dart';
import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/ambiental/conectar_ambiental_presenter.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:flutter/material.dart';

class ConectarAmbientalPage extends StatefulWidget {
  const ConectarAmbientalPage({super.key});

  @override
  State<ConectarAmbientalPage> createState() => _ConectarAmbientalPageState();
}

class _ConectarAmbientalPageState extends State<ConectarAmbientalPage>
    with IView {
  double kTamanhoLogo = 0;
  var presenter = ConectarAmbientalPresenter();

  @override
  Widget build(BuildContext context) {
    kTamanhoLogo = MediaQuery.of(context).size.height / 15;
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
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/esquilo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/tucano.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
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
              color: Color(kCorBgCinza),
              child: const Padding(
                padding: EdgeInsets.all(80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Conectar',
                            style: TextStyle(
                              color: Color(kCorPrimaria),
                              fontSize: 62,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Ambiental',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      kDescricaoPaginaPrincipal,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar() {
    return AppBar(
      title: customLogo(tamanhoLogo: kTamanhoLogo),
      centerTitle: true,
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
        const SizedBox(width: 8), // Espaçamento entre a imagem e o título
        const Text(
          kTitle,
          style: TextStyle(
            color: Color(kCorPrimaria),
            fontSize: 20, // Tamanho do texto
            fontWeight: FontWeight.bold, // Negrito
          ),
        ),
      ],
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
