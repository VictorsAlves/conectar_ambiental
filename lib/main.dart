import 'package:conectar_ambiental/agendamento/agendamento.dart';
import 'package:conectar_ambiental/ambiental/conectar_ambiental_page.dart';
import 'package:conectar_ambiental/constantes.dart';
import 'package:conectar_ambiental/landing/landing_page.dart';
import 'package:conectar_ambiental/trilha/trilha_guaratuba_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [],
      theme: ThemeData(
        primaryColor: const Color(kCorPrimaria),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LandingPage(),
        '/conectar-ambiental': (context) => const ConectarAmbientalPage(),
        '/agendamento': (context) => Agendamento(),
        '/trilha-guaratuba': (context) => TrilhaGuaratubalPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
