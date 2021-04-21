import 'package:flutter/material.dart';
import 'package:lector_qr/modelos/scan_modelo.dart';
import 'package:lector_qr/pages/direcciones_page.dart';
import 'package:lector_qr/pages/mapas_page.dart';
import 'package:lector_qr/provedores/bbdd_provider.dart';
import 'package:lector_qr/provedores/ui_provider.dart';
import 'package:lector_qr/widget_propios/cursor_navegacionBar.dart';
import 'package:lector_qr/widget_propios/scaner_botton.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MATERIAL'),
        elevation: 0,
        actions: [IconButton(icon: Icon(Icons.delete), onPressed: null)],
      ),
      body: _CuerpoHomePage(),
      bottomNavigationBar: customNavigationBar(),
      floatingActionButton: ScanBotton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _CuerpoHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el seleccion opciones
    final uiProvider = Provider.of<UiProvider>(context);

    //aqui cambia para mostrar la pagina respectiva
    final currentIndex = uiProvider.seleccionarOpcion;

    //PARA INGRESAR DATOS
    //final scanerTemporal = new ScanModelo(valor: 'https://www.google.com.mx/');
    //BdProvider.db.nuevoScan(scanerTemporal);
//PARA VER LOS REGISTROS DE LA BASE DE DATOS
    //BdProvider.db.seleccionarByID(16).then((scan) => print(scan.valor));
    //BdProvider.db.seleccionarTodo().then((print));
//PARA VER LA ELIMINACION EN CONSOLA
    //BdProvider.db.eliminarTodoScan().then(print);

//aqui controla si abre una pagina map o direcciones
    switch (currentIndex) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
        break;
      default:
        return MapasPage();
    }
  }
}
