import 'dart:async';

import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

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
    Timer(Duration(seconds: 1), () {
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
    tamanhoFonte = MediaQuery.of(context).size.width / 16;
    tamanhoFonteLogo = MediaQuery.of(context).size.width / 64;

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
                      padding: const EdgeInsets.all(8.0),
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
                        path:
                            'assets/LOGO_TRILHA_FUNDO TRANSPARENTE_COM TUCANO.png',
                        title:
                            ' serviços de consultoria ambiental, treinamentos, cursos e diagnósticos'),
                    logo(
                        path:
                            'assets/LOGO_AMBIENTAL_FUNDO TRABSPARENTE_OP1.png',
                        title:
                            'serviços especializados em birding observatory, e receptivo turistico')
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget logo({required String title, required String path}) {
    return Container(
      width: larguraCard,
      height: alturaCard,
      color: Colors.black45.withOpacity(0.5),
      // Define a cor de fundo com opacidade de 50%
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Imagem redonda do logo
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(path),
            ),
            SizedBox(height: 20),
            // Título descritivo

            Center(
              child: AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child: Padding(padding: const EdgeInsets.only(top:16,left: 16,right: 16,bottom: 16),child: Text(
                  title,
                  style:
                  TextStyle(fontSize: tamanhoFonteLogo, color: Colors.white),
                ),)
              ),
            ),
            // Mostra o título após alguns segundos
            const SizedBox(height: 20),
            // Botão para entrar na tela
            ElevatedButton(
              onPressed: () {
                // Adicione a navegação para a próxima tela aqui
                Navigator.popAndPushNamed(context, '/conectar-ambiental');
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
