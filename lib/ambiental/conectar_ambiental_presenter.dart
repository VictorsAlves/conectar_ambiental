import 'package:conectar_ambiental/IView.dart';
import 'package:conectar_ambiental/router.dart';
import 'package:flutter/cupertino.dart';

class ConectarAmbientalPresenter {
  late IView view;
  late BuildContext context;
  late ConectarAmbientalRouter router;

  void setContext(BuildContext context) {
    this.context = context;
    router = ConectarAmbientalRouter(context);
  }

  void navigateTo() {
    router.goToInicio();
  }
}
