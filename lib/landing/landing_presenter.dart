import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/router.dart';
import 'package:flutter/material.dart';

class LandingPresenter {
  late IView view;
  late BuildContext context;
  late ConectarAmbientalRouter router;

  void setContext(BuildContext context) {
    this.context = context;
    router = ConectarAmbientalRouter(context);
  }

  void navigate(int index) {
    switch (index) {
      case 1:
        router.goToAmbiental();
        break;
      case 2:
        router.goToGuaratuba();
      default:
        router.goToInicio();
    }
  }
}
