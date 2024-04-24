import 'package:carousel_slider/carousel_slider.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:flutter/material.dart';

class TrilhaGuaratubalPage extends StatefulWidget {
  const TrilhaGuaratubalPage({super.key});

  @override
  State<TrilhaGuaratubalPage> createState() => _TrilhaGuaratubaPageState();
}

class _TrilhaGuaratubaPageState extends State<TrilhaGuaratubalPage> {
  double kTamanhoLogo = 0;

  @override
  Widget build(BuildContext context) {
    kTamanhoLogo = MediaQuery.of(context).size.height / 20;
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Text('trilha guaratuba')],
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
                onPressed: () =>
                    Navigator.of(context).pushNamed('/agendamento'),
                child: const Text('Agendamento'),
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
}
