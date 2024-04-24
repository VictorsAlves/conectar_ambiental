import 'package:conectar_ambiental/IInteractor.dart';
import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/router.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class AgendamentoPresenter {
  late IView view;
  late IInteractor interactor;
  late BuildContext context;
  late ConectarAmbientalRouter router;

  void setView(IView view) {
    this.view = view;
  }

  void setContext(BuildContext context) {
    this.context = context;
    router = ConectarAmbientalRouter(context);
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Agendamento de Visita'),
        );
      },
    ));

    final output = await interactor.output();
    final file = File('${output.path}/visit_schedule.pdf');
    await file.writeAsBytes(await pdf.save());

    var pdfPath = file.path;
  }

  Widget getForm() {
    return Column(children: <Widget>[
      ListTile(
        title: const Text('Cadastrar Pessoa'),
        trailing: const Icon(Icons.arrow_right_sharp),
        onTap: () {
          showModal();
        },
      ),
      const Divider(),
      ListTile(
        title: const Text('Cadastrar barraca'),
        trailing: const Icon(Icons.arrow_right_sharp),
        onTap: () {
          //TODO:
        },
      ),
      const Divider(),
      ListTile(
        title: const Text('gerar pix'),
        trailing: const Icon(Icons.arrow_right_sharp),
        onTap: () {
          //TODO
        },
      ),
    ]);
  }

  showModal() {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
