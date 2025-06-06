import 'package:conectar_ambiental/ambiental/conectar_ambiental_page.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/landing/landing_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'conteudo/conteudo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      }),
      localizationsDelegates: const [],
      theme: ThemeData(
        primaryColor: const Color(kCorPrimaria),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LandingPage(),
        '/conectar-ambiental': (context) => const ConectarAmbientalPage(),
        '/conteudos': (context) => const ConteudoPage()
      },
    );
  }
}
