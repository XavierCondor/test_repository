import 'package:flutter/material.dart';
import 'package:lector_qr/provedores/ui_provider.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class customNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final valoropcional = uiProvider
        .seleccionarOpcion; //aqui une el cambio de pantalla con el boton

    return BottomNavigationBar(
        onTap: (int i) => uiProvider.seleccionarOpcion = i,
        currentIndex: valoropcional,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Direcciones')
        ]);
  }
}
