import 'package:flutter/cupertino.dart';

abstract mixin class IView {
  void defineState();
  void setContext(BuildContext context);
  void showPopUp(){}
  IView getView();
}
