import 'dart:async';

import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/landing/landing_presenter.dart';
import 'package:flutter/material.dart';

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
  double tamanhoFonte = 0;
  double tamanhoFonteLogo = 0;
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
    alturaCard = MediaQuery.of(context).size.height / 2;
    larguraCard = MediaQuery.of(context).size.width / 3;
    double _opacity = 0.0; // Inicializa a opacidade como 0
    tamanhoFonte = MediaQuery.of(context).size.width / 10;
    tamanhoFonteLogo = MediaQuery.of(context).size.width / 64;
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
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 8.0, left: 50.0, bottom: 100),
                      child: Text(
                        'Visitar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: tamanhoFonte,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    logo(
                        path: kPathLogoAmbiental,
                        title: kDescricaoAmbiental,
                        index: 1),
                    logo(
                        path: kPathLogoGuaratuba,
                        title: kDescricaoGuaratuba,
                        index: 2)
                  ],
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
              radius: 90,
              backgroundImage: AssetImage(path),
            ),
            SizedBox(height: 20),
            // Título descritivo

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
                          fontSize: tamanhoFonteLogo, color: Colors.white),
                    ),
                  )),
            ),
            // Mostra o título após alguns segundos
            const SizedBox(height: 20),
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
