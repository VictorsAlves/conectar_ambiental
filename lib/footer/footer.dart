import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return rodape();
  }

  Widget rodape() {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 50.0,
        child: Center(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: '© 2024. Todos os direitos reservados. ',
                ),
                TextSpan(
                  text: 'Conectar Ambiental. ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: 'Desenvolvido por '),
                TextSpan(
                  text: 'Wolfdevelloper ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
