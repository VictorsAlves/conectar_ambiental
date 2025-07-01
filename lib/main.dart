import 'package:conectar_ambiental/ambiental/conectar_ambiental_page.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/escrita/escrever_artigo_page.dart';
import 'package:conectar_ambiental/postagem/novomodelo/editor_completo_page.dart' show EditorCompletoPage, RichTextEditorPage;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'conteudo/conteudo_page.dart';

void main() {
  usePathUrlStrategy();
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
        '/': (context) => const ConectarAmbientalPage(),
        '/editor': (context) => const EditorCompletoPage(),
        '/conteudos': (context) =>  ConteudoPage(),
        '/escrever-artigo': (context) =>  EscreverArtigoPage(),
      },
    );
  }
}
