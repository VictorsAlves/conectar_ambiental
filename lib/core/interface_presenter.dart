import 'package:conectar_ambiental/router.dart' show ConectarAmbientalRouter;
import 'package:flutter/widgets.dart';

import '../interface_view.dart' show IView;

abstract class IPresenter{
  late IView view;
  late BuildContext context;
  late ConectarAmbientalRouter router;

  void setContext(BuildContext context) {
    this.context = context;
    router = ConectarAmbientalRouter(context);
  }


}