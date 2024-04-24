import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConectarAmbientalRouter {
  BuildContext context;

  ConectarAmbientalRouter(this.context);

  void goToAgendamento() {
    Navigator.of(context).pushNamed('/agendamento');
  }

  void goToInicio() {
    Navigator.of(context).pushNamed('/');
  }

  void goToGuaratuba() {
    Navigator.of(context).pushNamed('/trilha-guaratuba');
  }


  void goToAmbiental() {
    Navigator.of(context).pushReplacementNamed('/conectar-ambiental');
  }


}
