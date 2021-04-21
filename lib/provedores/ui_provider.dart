import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _seleccionarOpcion = 0;
  int get seleccionarOpcion {
    return this._seleccionarOpcion;
  }

  set seleccionarOpcion(int i) {
    this._seleccionarOpcion = i;
    notifyListeners();
  }
}
