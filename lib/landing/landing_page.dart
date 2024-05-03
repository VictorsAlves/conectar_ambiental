import 'dart:async';

import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/landing/landing_presenter.dart';
import 'package:flutter/material.dart';

import '../footer/footer.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  late LandingPresenter presenter = LandingPresenter();

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _showTitle = false;
  double alturaCard = 0;
  double larguraCard = 0;
  double tamanhoTitulo = 0;
  double tamanhoSubtitulo = 0;
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    // Define um temporizador para mostrar o título após 3 segundos
    Timer(Duration(milliseconds: 100), () {
      setState(() {
        _showTitle = true;
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    alturaCard = MediaQuery.of(context).size.height / 1.8;
    larguraCard = MediaQuery.of(context).size.width / 3;
    double _opacity = 0.0; // Inicializa a opacidade como 0
    tamanhoTitulo = MediaQuery.of(context).size.width / 10;
    tamanhoSubtitulo = MediaQuery.of(context).size.width / 40;
    widget.presenter.setContext(context);
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tucano.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Visitar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: tamanhoTitulo,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Container(
                  height: 580,
                  width: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      logo(
                          path: kPathLogoAmbiental,
                          title: kDescricaoAmbiental,
                          index: 1),
                      logo(
                          path: kPathLogoGuaratuba,
                          title: kDescricaoGuaratuba,
                          index: 2),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget logo(
      {required String title, required String path, required int index}) {
    return Container(
      width: larguraCard,
      height: alturaCard,
      color: Colors.black45.withOpacity(0.5),
      // Define a cor de fundo com opacidade de 50%
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Imagem redonda do logo
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              foregroundImage: AssetImage(path),
            ),
            Center(
              child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 1),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 16),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: tamanhoSubtitulo, color: Colors.white),
                    ),
                  )),
            ),

            // Botão para entrar na tela
            ElevatedButton(
              onPressed: () {
                // Adicione a navegação para a próxima tela aqui
                widget.presenter.navigate(index);
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
