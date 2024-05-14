import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/agendamento/agendamento_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class Agendamento extends StatefulWidget {
  const Agendamento({super.key});

  @override
  _VisitScheduleScreenState createState() => _VisitScheduleScreenState();
}

class _VisitScheduleScreenState extends State<Agendamento> with IView {
  String pdfPath = '';
  var presenter = AgendamentoPresenter();

  @override
  Widget build(BuildContext context) {
    presenter.setView(this);
    presenter.setContext(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendamento de Visita'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            presenter.getForm(),
            ElevatedButton(
              onPressed: () => presenter.generatePDF(),
              child: const Text('Gerar PDF de Agendamento'),
            ),
            const SizedBox(height: 20),
            if (pdfPath.isNotEmpty)
              Expanded(
                child: PDFView(
                  filePath: pdfPath,
                  autoSpacing: false,
                  swipeHorizontal: true,
                  pageSnap: true,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void defineState() {
    // TODO: implement defineState
  }

  @override
  setContext(BuildContext context) {
    presenter.setContext(context);
  }

  @override
  IView getView() {
    // TODO: implement getView
    throw UnimplementedError();
  }
}
